From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Fri, 31 May 2002 21:02:23 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF7664F.D74991F2@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
		<3CF5B58B.59E5A233@boosthardware.com>
		<s5hwutkhhhj.wl@alsa2.suse.de>
		<3CF74113.46D53687@boosthardware.com>
		<s5hofewhd1u.wl@alsa2.suse.de> <s5hk7pkh9pi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Here's the descriptor. Now there are two entries in the card2,3,4 dirs.
'descriptor' and 'id'. The descriptor files all appear to be the same. 

----
M Audio USB AudioSport Quattro (tm)

00: 09 02 ce 03 0a 01 00 40 00 09 04 00 00 00 01 01
10: 00 02 0a 24 01 00 01 34 00 02 01 02 0c 24 02 05
20: 01 01 00 02 03 00 00 00 09 24 03 06 01 06 00 05
30: 00 0c 24 02 01 01 06 00 02 03 00 00 00 09 24 03
40: 02 01 01 00 01 00 09 04 01 00 00 01 02 00 00 09
50: 04 01 04 01 01 02 00 00 07 24 01 05 01 01 00 11
60: 24 02 01 02 02 10 03 11 2b 00 22 56 00 44 ac 00
70: 09 05 03 09 c0 00 01 00 00 07 25 01 01 00 00 00
80: 09 04 02 00 00 01 02 00 00 09 04 02 04 01 01 02
90: 00 00 07 24 01 02 01 01 00 11 24 02 01 02 02 10
a0: 03 11 2b 00 22 56 00 44 ac 00 09 05 85 0d c0 00
b0: 01 00 00 07 25 01 01 00 00 00 09 04 03 00 00 01
c0: 01 00 02 0a 24 01 00 01 34 00 02 04 05 0c 24 02
d0: 05 01 01 00 02 03 00 00 00 09 24 03 06 01 06 00
e0: 05 00 0c 24 02 01 01 06 00 02 03 00 00 00 09 24
f0: 03 02 01 01 00 01 00 09 04 04 00 00 01 02 00 00
100: 09 04 04 01 01 01 02 00 00 07 24 01 05 01 01 00
110: 0e 24 02 01 02 03 18 02 88 58 01 00 77 01 09 05
120: 03 09 40 02 01 00 00 07 25 01 01 00 00 00 09 04
130: 04 03 01 01 02 00 00 07 24 01 05 01 01 00 14 24
140: 02 01 02 03 18 04 11 2b 00 22 56 00 44 ac 00 80
150: bb 00 09 05 03 09 20 01 01 00 00 07 25 01 01 00
160: 00 00 09 04 04 04 01 01 02 00 00 07 24 01 05 01
170: 01 00 14 24 02 01 02 02 10 04 11 2b 00 22 56 00
180: 44 ac 00 80 bb 00 09 05 03 09 c0 00 01 00 00 07
190: 25 01 01 00 00 00 09 04 05 00 00 01 02 00 00 09
1a0: 04 05 01 01 01 02 00 00 07 24 01 02 01 01 00 0e
1b0: 24 02 01 02 03 18 02 88 58 01 00 77 01 09 05 85
1c0: 0d 40 02 01 00 00 07 25 01 01 00 00 00 09 04 05
1d0: 03 01 01 02 00 00 07 24 01 02 01 01 00 14 24 02
1e0: 01 02 03 18 04 11 2b 00 22 56 00 44 ac 00 80 bb
1f0: 00 09 05 85 0d 20 01 01 00 00 07 25 01 01 00 00
200: 00 09 04 05 04 01 01 02 00 00 07 24 01 02 01 01
210: 00 14 24 02 01 02 02 10 04 11 2b 00 22 56 00 44
220: ac 00 80 bb 00 09 05 85 0d c0 00 01 00 00 07 25
230: 01 01 00 00 00 09 04 06 00 00 01 01 00 02 0a 24
240: 01 00 01 34 00 02 07 08 0c 24 02 07 01 01 00 02
250: 03 00 00 00 09 24 03 08 01 06 00 07 00 0c 24 02
260: 03 01 06 00 02 03 00 00 00 09 24 03 04 01 01 00
270: 03 00 09 04 07 00 00 01 02 00 00 09 04 07 01 01
280: 01 02 00 00 07 24 01 07 01 01 00 0e 24 02 01 02
290: 03 18 02 88 58 01 00 77 01 09 05 04 09 40 02 01
2a0: 00 00 07 25 01 01 00 00 00 09 04 07 03 01 01 02
2b0: 00 00 07 24 01 07 01 01 00 14 24 02 01 02 03 18
2c0: 04 11 2b 00 22 56 00 44 ac 00 80 bb 00 09 05 04
2d0: 09 20 01 01 00 00 07 25 01 01 00 00 00 09 04 07
2e0: 04 01 01 02 00 00 07 24 01 07 01 01 00 14 24 02
2f0: 01 02 02 10 04 11 2b 00 22 56 00 44 ac 00 80 bb
300: 00 09 05 04 09 c0 00 01 00 00 07 25 01 01 00 00
310: 00 09 04 08 00 00 01 02 00 00 09 04 08 01 01 01
320: 02 00 00 07 24 01 04 01 01 00 0e 24 02 01 02 03
330: 18 02 88 58 01 00 77 01 09 05 86 0d 40 02 01 00
340: 00 07 25 01 01 00 00 00 09 04 08 03 01 01 02 00
350: 00 07 24 01 04 01 01 00 14 24 02 01 02 03 18 04
360: 11 2b 00 22 56 00 44 ac 00 80 bb 00 09 05 86 0d
370: 20 01 01 00 00 07 25 01 01 00 00 00 09 04 08 04
380: 01 01 02 00 00 07 24 01 04 01 01 00 14 24 02 01
390: 02 02 10 04 11 2b 00 22 56 00 44 ac 00 80 bb 00
3a0: 09 05 86 0d c0 00 01 00 00 07 25 01 01 00 00 00
3b0: 09 04 09 00 03 ff 00 00 00 07 05 81 03 20 00 01
3c0: 07 05 82 02 20 00 00 07 05 02 02 20 00 00 
----
-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
