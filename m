From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 5/7] ALSA: USB-audio: Add quirk for Zoom
 R16 playback
Date: Thu, 15 Oct 2015 20:21:59 +0800
Message-ID: <201510152008.jFnwyuQw%fengguang.wu@intel.com>
References: <1444906657-16791-6-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 557F0260453
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 14:22:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1444906657-16791-6-git-send-email-ricardw@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Ricard Wanderlof <ricard2005@butoba.net>, kbuild-all@01.org, Ricard Wanderlof <ricardw@axis.com>
List-Id: alsa-devel@alsa-project.org

Hi Ricard,

[auto build test WARNING on sound/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Ricard-Wanderlof/ALSA-USB-audio-Support-Zoom-R16-playback/20151015-190259
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/usb/endpoint.c:214:39: sparse: incorrect type in assignment (different base types)
   sound/usb/endpoint.c:214:39:    expected unsigned int [unsigned] [usertype] packet_length
   sound/usb/endpoint.c:214:39:    got restricted __le32 [usertype] <noident>
--
>> sound/usb/pcm.c:1424:31: sparse: incorrect type in assignment (different base types)
   sound/usb/pcm.c:1424:31:    expected unsigned int [unsigned] [usertype] packet_length
   sound/usb/pcm.c:1424:31:    got restricted __le32 [usertype] <noident>

vim +214 sound/usb/endpoint.c

   198	
   199		for (i = 0; i < ctx->packets; ++i) {
   200			unsigned int offset;
   201			unsigned int length;
   202			int counts;
   203	
   204			if (ctx->packet_size[i])
   205				counts = ctx->packet_size[i];
   206			else
   207				counts = snd_usb_endpoint_next_packet_size(ep);
   208	
   209			length = counts * ep->stride; /* number of silent bytes */
   210			offset = offs * ep->stride + extra * i;
   211			urb->iso_frame_desc[i].offset = offset;
   212			urb->iso_frame_desc[i].length = length + extra;
   213			if (extra) {
 > 214				packet_length = cpu_to_le32(length);
   215				memcpy(urb->transfer_buffer + offset,
   216				       &packet_length, sizeof(packet_length));
   217			}
   218			memset(urb->transfer_buffer + offset + extra,
   219			       ep->silence_value, length);
   220			offs += counts;
   221		}
   222	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
