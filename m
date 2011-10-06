From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [smatch stuff] reading beyond the end of the array in
 build_feature_ctl()
Date: Thu, 6 Oct 2011 16:39:48 +0300
Message-ID: <20111006133948.GA5217@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 59329103839
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 15:40:01 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Smatch complains about a potential read past the end of the array in
build_feature_ctl().

sound/usb/mixer.c +1035 build_feature_ctl(34)
	error: buffer overflow 'audio_feature_info' 13 <= 14

This is in the init code so probably it's correct, and I've just
missed how it works.  Can you take a look?

The problem is that audio_feature_info[] has 13 elements, but Smatch
thinks control - 1 can go up to 14 so we're two elements past the end.

  1035          cval->val_type = audio_feature_info[control-1].type;

Smatch get the value for "control" from "i" in parse_audio_feature_unit().

sound/usb/mixer.c
  1261          } else { /* UAC_VERSION_2 */
  1262                  for (i = 0; i < 30/2; i++) {
  1263                          unsigned int ch_bits = 0;
  1264                          unsigned int ch_read_only = 0;
  1265  
  1266                          for (j = 0; j < channels; j++) {
  1267                                  unsigned int mask = snd_usb_combine_bytes(bmaControls + csize * (j+1), csize);
  1268                                  if (uac2_control_is_readable(mask, i)) {
  1269                                          ch_bits |= (1 << j);
  1270                                          if (!uac2_control_is_writeable(mask, i))
  1271                                                  ch_read_only |= (1 << j);
  1272                                  }
  1273                          }
  1274  
  1275                          /* NOTE: build_feature_ctl() will mark the control read-only if all channels
  1276                           * are marked read-only in the descriptors. Otherwise, the control will be
  1277                           * reported as writeable, but the driver will not actually issue a write
  1278                           * command for read-only channels */
  1279                          if (ch_bits & 1) /* the first channel must be set (for ease of programming) */
  1280                                  build_feature_ctl(state, _ftr, ch_bits, i, &iterm, unitid, ch_read_only);
                                                                                ^
"i" can be 13 here.

  1281                          if (uac2_control_is_readable(master_bits, i))
  1282                                  build_feature_ctl(state, _ftr, 0, i, &iterm, unitid,
                                                                          ^
"i" maybe can go up to 14 here, I'm not sure.

  1283                                                    !uac2_control_is_writeable(master_bits, i));
  1284                  }
  1285          }

regards,
dan carpenter
