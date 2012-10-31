From: Massimo Del Fedele <max@veneto.com>
Subject: Fix for Asus G75 notebook subwoofer
Date: Wed, 31 Oct 2012 17:49:39 +0100
Message-ID: <k6rkr2$usv$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E38A261694
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 17:49:51 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TTbUM-0008F6-Cn
 for alsa-devel@alsa-project.org; Wed, 31 Oct 2012 17:49:58 +0100
Received: from host247-229-dynamic.9-87-r.retail.telecomitalia.it
 ([87.9.229.247]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 17:49:58 +0100
Received: from max by host247-229-dynamic.9-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 17:49:58 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This code fixes surround path of asus G75; i'll drop here as a function to be called
before codec initialization (I did it in static int patch_vt2002P() ) because I don't
know how to detect the notebook and apply it only when needed (I'm new to alsa code).

/* Fixes for Asus G75 subwoofer
    pin 24 is marked as speaker by bios -- should mark as line
    pin 33 has a wrong connection to out-of-range nid #3e
*/
  static int fix_asus_g75_subwoofer(struct hda_codec *codec)
  {
	/* right connection to pin widget #33 */
	hda_nid_t conn[8] = {0x1c};
	unsigned int conf;
	
	/* Fix connection of pin widget #33 on VT1802p
	 * reported connection (33-1e) refers to non-existent widget #1e which in turn
	 * reports a connection to #1c; we skip nonexistent 1e widget landing directly
	 * on 1c one
	 */
  	snd_hda_override_conn_list(codec, 0x33, 1, conn);

	// pin 24 should be marked as line out pin (not speaker as in bios)
	// and as AC_JACK_PORT_COMPLEX connection to avoid to be taken by autoparser as a speaker
	conf = snd_hda_codec_get_pincfg(codec, 0x24);
	conf = conf & ~AC_DEFCFG_DEVICE;
	conf = (conf & ~AC_DEFCFG_PORT_CONN) | (AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT);
	snd_hda_codec_set_pincfg(codec, 0x24, conf);
	
	// pin 33 should be marked as line out pin (not speaker as in bios)
	// and as AC_JACK_PORT_COMPLEX, not AC_JACK_PORT_NONE as in bios
	conf = snd_hda_codec_get_pincfg(codec, 0x33);
	conf = conf & ~AC_DEFCFG_DEVICE;
	conf = (conf & ~AC_DEFCFG_PORT_CONN) | (AC_JACK_PORT_COMPLEX << AC_DEFCFG_PORT_CONN_SHIFT);
	snd_hda_codec_set_pincfg(codec, 0x33, conf);

	return 0;
}

I guess that the fix on NID #33 should be applied anyways on VT1802p, because by now it connects to a non-existing widget
(well, it does exist but is not documented and out of NID range; it should be a stereo-to-mono mixer).
BTW, also NID #34, which has 2 connections, has one of them to non-existing nid above; in my case it does no harm :

Widget #24 -- ANALOG STEREO PIN COMPLEX
	Input from widgets :  14 3e       <-- widget 3e is out of range, but connects to 1c widget
	Connection type : JACK
	Device          : LINE OUT
	Does NOT support unsolicited response
	Out amp  present
	In amp NOT present

Ciao

Max
