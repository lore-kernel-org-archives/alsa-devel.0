From: Paul Davis <pbd@op.net>
Subject: Re: Re: hdsp on big-endian
Date: Tue, 21 May 2002 13:22:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17AE3F-0000nZ-00@usw-sf-list1.sourceforge.net>
References: <s5hy9edfn49.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 21 May 2002 19:04:54 +0200."
             <s5hy9edfn49.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi Paul,
>
>i converted b_swap's to cpu_to_xxx and xxx_to_cpu macros, and during
>that, found that the following part may not work correctly on BE.
>
>static inline unsigned long long hdsp_read64 (hdsp_t *hdsp, int reg)
>{
>	unsigned long long val;
>	val = hdsp_read(hdsp, reg);
>	val = (val<<32)|hdsp_read(hdsp, reg + 4);
>
>	return le64_to_cpu(val);
>}
>
>since hdsp_read returns the already converted 32bit word, the
>resultant 64bit word will be flipped again badly.
>i think we don't need here any endian conversion here.
>could you confirm this?

thats correct. its not significant yet, because i am still not quite
sure "where" the RMS meters (the only 64 bit registers) actually live.

the one other area of this that i am not sure about is the area where
we write the firmware. perhaps someone can help me out, since
endianness always fries my mind. that firmware is
stored/declared/defined as a char array. its written as a series of 32
bit words. the char array was taken from the OS X driver (i.e. for a
big-endian system). The OS X driver explicitly did *not* byteswap the
data when it wrote it. I assumed, therefore, that I should byteswap it
on an LE system. That didn't work - I just went back to writing it
with swapping, and the firmware download worked. The question now
arises: what to do on a BE system? its probably just my lousy
programming skills in this area, but i would have thought that:

    char c[4] = { 0xfe, 0xed, 0xfa, 0xce };
    int  i  = *((int *) c);

would give different results on BE and LE systems ...

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
