From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Cherry Trail + RT5645 devices with a mono speaker ?
Date: Fri, 27 Oct 2017 12:18:02 +0200
Message-ID: <d158e706-95a8-c1bc-2c8b-b198e16cbacd@redhat.com>
References: <f5ad13fc-2b25-7f64-d5f0-6ad035fd09ab@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7026E85AB@RTITMBSV02.realtek.com.tw>
 <c5eb261c-4a02-d793-aeab-abc845579343@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7026F4A1F@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 94EE0266A0C
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 12:18:07 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7026F4A1F@RTITMBSV02.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Albert Chen <albertchen@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 27-10-17 08:39, Bard Liao wrote:
>> -----Original Message-----
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Sent: Thursday, October 26, 2017 11:09 PM
>> To: Bard Liao; Pierre-Louis Bossart
>> Cc: alsa-devel@alsa-project.org
>> Subject: Re: Cherry Trail + RT5645 devices with a mono speaker ?
>>
>> Hi,
>>
>> On 16-10-17 13:31, Bard Liao wrote:
>>>> -----Original Message-----
>>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>>>> Sent: Sunday, October 15, 2017 2:12 AM
>>>> To: Pierre-Louis Bossart; Bard Liao
>>>> Cc: alsa-devel@alsa-project.org
>>>> Subject: Cherry Trail + RT5645 devices with a mono speaker ?
>>>>
>>>> Hi Pierre-Louis, Bard,
>>>>
>>>> I've been looking into getting some Cherry Trail + RT5645
>>>> devices with a mono speaker I have to work properly.
>>>>
>>>> Specifically the goal is to mix the right channel into
>>>> the left output, so that sounds which are only played
>>>> over the right channel do not get lost.
>>>>
>>>> I'm using this UCM file:
>>>> https://github.com/plbossart/UCM/blob/master/byt-rt5640/HiFi
>>>>
>>>> Looking at the rtl5640 UCM file, getting the mono speaker
>>>> to work (in a first simple attempt) should be as simple
>>>> as replacing:
>>>>
>>>>                    cset "name='SPOR MIX SPKVOL R Switch' on"
>>>>
>>>> With
>>>>
>>>>                    cset "name='SPOL MIX SPKVOL R Switch' on"
>>>>
>>>> But this does not work, the speaker test sound for the
>>>> right speaker is still silent (works with headphones).
>>>>
>>>> I've also looked into directly poking the
>>>> RT5645_SPO_MIXER i2c register for testing, but when
>>>> checking its value with the original unmodified UCM
>>>> file:
>>>>
>>>> [root@localhost ~]# i2cget -y -f 1 0x1a 0x48  w
>>>> 0x06c8
>>>>
>>>> That is: 0xc806 as the output of i2cget "w" mode
>>>> needs byteswapping. Note that both the
>>>> RT5645_M_SV_L_SPM_L and RT5645_M_SV_R_SPM_L bits
>>>> are already cleared, which is weird as this is
>>>> before I've modified anything. Also the
>>>> RT5645_M_SV_R_SPM_R bit is cleared, but that is
>>>> expected.
>>>>
>>>> Even if I manually set reg 0x48 to 0x07c8 which AFAIK
>>>> should enable output of both left and right channels
>>>> on the left speaker I still only get sounds played
>>>> on the left channel.
>>>>
>>>> Any insights / help with this would be very much
>>>> welcome.
>>>
>>> Could you dump all registers for us?
>>
>> Here you go:
>>
>>        0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
>> 00: 0000 0808 c8c8 c8c8 0ac8 0000 0000 0000
>> 08: 0000 0000 0200 2738 00e0 0000 0000 0000
>> 10: 0000 0000 0000 0000 3333 0000 004b 0000
>> 18: 8b01 afaf afaf 1100 3f3f 7f7f 00f0 0000
>> 20: 00a0 0000 0000 0000 0000 0000 0000 2038
>> 28: 3030 8080 1616 4444 a0aa 0000 0000 0210
>> 30: 0000 0050 0000 0000 0000 0000 0000 0000
>> 38: 0000 0000 0000 0000 7d00 0000 7d00 0000
>> 40: 1c00 0000 1c00 0000 0000 0050 3800 3800
>> 48: 06c8 0000 0400 0000 1f03 0000 0000 ff01
>> 50: 0000 0000 ff01 00f0 0000 0000 1101 6400
>> 58: 0eef f0f0 0eef f0f0 0eef f0f0 00f0 0000
>> 60: 0000 019b 0008 1ae8 0402 0230 00c0 0000
>> 68: 0000 0000 0000 0000 aa0a 0000 0000 0000
>> 70: 8380 0080 0080 7017 003e 0924 0a00 0058
>> 78: 0000 2301 0080 0000 0000 0000 0000 0000
>> 80: 0040 030f 0030 000c 1111 0000 0800 0000
>> 88: 0000 0000 2001 0000 0300 0000 0000 4011
>> 90: 3606 060c 0000 0801 0202 0000 0000 0000
>> 98: 0000 0000 8421 0a01 ea0a 0c00 0004 0000
>> a0: e8a0 5900 0100 0000 0000 0000 0000 0000
>> a8: 0000 0000 0000 0000 0000 0000 0060 0000
>> b0: 0060 0000 0000 1f00 0c02 001f 0000 0040
>> b8: 0000 0000 0000 0000 0000 8002 0000 8011
>> c0: 0080 0000 0000 0020 0000 0000 0000 0000
>> c8: 0000 0000 0000 0000 0000 0000 0000 1418
>> d0: 9006 171c 0000 20b3 0000 0000 0004 0000
>> d8: 0000 0908 0000 0300 4900 1b00 0000 0000
>> e0: 0000 0000 0000 0000 0000 0000 0080 0007
>> e8: 0080 0007 200f 0000 00b3 0000 0000 0000
>> f0: 1f00 0c02 001f 0000 0040 0000 0000 0000
>> f8: 0000 0000 6120 4040 001a 0400 ec10 0863
>>
>> Note that i2cdump swaps the low and high bytes
>> in all the 16 bit words.
> 
> Could you dump registers by regmap?
> cat /sys/kernel/debug/regmap/<bus name>/registers
> It will be more readable for me.

Ok here you go:

000: 0000
001: 0808
002: c8c8
003: c8c8
00a: 0002
00b: 3827
00c: e000
00d: 0000
00e: 0000
00f: 0000
014: 3333
016: 4b00
018: 018b
019: afaf
01a: afaf
01b: 0011
01c: 3f3f
01d: 7f7f
01e: f000
020: a000
027: 3820
028: 3030
029: 8080
02a: 1616
02b: 4444
02c: aaa0
02d: 0000
02f: 1002
031: 5000
032: 0000
033: 0000
034: 0000
035: 0000
03b: 0000
03c: 007d
03d: 0000
03e: 007d
03f: 0000
040: 001c
041: 0000
042: 001c
045: 5000
046: 0038
047: 0038
048: c806
04a: 0004
04d: 0000
04e: 0000
04f: 01ff
050: 0000
051: 0000
052: 01ff
053: f000
056: 0111
057: 0064
058: ef0e
059: f0f0
05a: ef0e
05b: f0f0
05c: ef0e
05d: f0f0
05e: f000
05f: 0000
061: 9b01
062: 0800
063: e81a
064: 0204
065: 3002
066: c000
06a: 0037
06c: fc00
070: 8083
071: 8000
072: 8000
073: 1770
074: 3e00
075: 2409
076: 000a
077: 5800
078: 0000
079: 0123
07a: 8000
080: 4000
081: 0f03
082: 3000
083: 0c00
084: 1111
085: 0000
08a: 0120
08e: 0000
08f: 1140
090: 0636
091: 0c06
093: 0108
094: 0202
095: 0000
09a: 2184
09b: 010a
09c: 0aea
09d: 000c
09e: 0400
0a0: a0e8
0a1: 0059
0a2: 0001
0ae: 6000
0af: 0000
0b0: 6000
0b1: 0000
0b2: 0000
0b3: 001f
0b4: 020c
0b5: 1f00
0b6: 0000
0b7: 4000
0bb: 0000
0bc: 0000
0bd: 0280
0be: 0000
0bf: 1180
0c0: 8000
0c1: 0000
0c2: 0000
0c3: 2000
0cd: 0000
0ce: 0000
0cf: 1814
0d0: 0690
0d1: 1c17
0d3: b320
0d4: 0000
0d6: 0400
0d9: 0809
0da: 0000
0db: 0003
0dc: 0049
0dd: 001b
0df: 0000
0e0: 4000
0e6: 8000
0e7: 0200
0e9: 0700
0ec: b300
0ed: 0000
0f0: 001f
0f1: 020c
0f2: 1f00
0f3: 0000
0f4: 4000
0f8: 0000
0f9: 0000
0fa: 2061
0fb: 4040
0fc: 1a00
0fd: 0004
0fe: 10ec
0ff: 6308
100: 0aaa
101: 2e60
102: a680
103: 7418
104: 0000
105: 0306
106: ffff
107: c7c0
108: 2e60
109: a680
10a: 7418
10b: 0000
10c: 0306
10d: ffff
10e: c7c0
10f: 0000
110: 0000
111: a814
112: 0002
113: 8aaa
114: 1aaa
115: aaa0
116: 0000
117: 0000
118: 0000
119: 0000
11a: 0000
11b: 0200
11c: fd70
11d: 0247
11e: 0000
11f: 0155
120: 611f
121: 4040
122: 0052
123: c004
124: 0430
125: 7530
126: 0000
127: 0000
128: 0000
129: 0000
12a: 0000
12b: 0000
12c: 0000
12d: 0000
12e: 0000
12f: 0000
130: 0000
131: 0ddd
132: 0ddd
133: 0000
134: 0000
135: 5155
136: 0000
137: fc00
138: 79a1
139: 0000
13a: 0002
13b: 0000
13c: 0000
13d: 3600
13e: 1f80
13f: 0000
140: 6883
141: d3ce
142: 352d
143: 00eb
144: 0000
145: 0000
146: 0000
147: 0000
148: 0000
149: 0000
14a: 0000
14b: 0000
14c: 0000
14d: 0000
14e: 0000
14f: 0000
150: 0000
151: 0000
152: 0000
153: 0000
154: 0000
155: 0000
156: 0000
157: 0000
158: 0000
159: 0000
15a: 0000
15b: 0000
15c: 0000
15d: 0000
15e: 0000
15f: 0000
160: 0000
161: 0000
162: 0000
163: 3717
164: 4c6a
165: e41b
166: 2a13
167: b600
168: c730
169: 35d4
16a: 00bf
16b: 0000
16c: 0000
16d: 0000
16e: 0000
16f: 0000
170: 0000
171: 0000
172: 0000
173: 0000
174: 0000
175: 0000
176: 0000
177: 1f01
178: 4040
179: 0000
17a: 3f3f
17b: 0000
17c: 0000
17d: 0000
17e: 0000
17f: 0000
180: 3f3f
181: 0000
182: 0000
183: 0000
184: 0000
185: 0000
186: 004c
187: 0000
188: 0000
189: 0000
18a: 0000
18b: 0000
18c: 0000
18d: 0000
18e: 0000
18f: 0000
190: 3300
191: 2200
192: 0000
193: 0000
194: 8700
195: 7dc2
196: a178
197: 5383
198: 7dc2
199: a178
19a: 5383
19b: 003e
19c: 02c1
19d: d37d
19e: 0000
19f: 0000
1a0: 0000
1a1: 0000
1a2: 0000
1a3: 0000
1a4: 1c10
1a5: 01f4
1a6: 1c10
1a7: 01f4
1a8: 0000
1a9: 0000
1aa: 0000
1ab: 0000
1ac: 0000
1ad: 0000
1ae: c882
1af: 1c10
1b0: 01f4
1b1: c882
1b2: 1c10
1b3: 01f4
1b4: e904
1b5: 1c10
1b6: 01f4
1b7: e904
1b8: 1c10
1b9: 01f4
1ba: e904
1bb: 1c10
1bc: 01f4
1bd: e904
1be: 1c10
1bf: 01f4
1c0: 1c10
1c1: 01f4
1c2: 1c10
1c3: 01f4
1c4: 2000
1c5: 0000
1c6: 2000
1c7: 2000
1c8: 0000
1c9: 2000
1ca: 0800
1cb: 0800
1cc: 0800
1cd: 0800
1ce: 1c10
1cf: 01f4
1d0: e904
1d1: 1c10
1d2: 01f4
1d3: e904
1d4: 1c10
1d5: 01f4
1d6: e904
1d7: 1c10
1d8: 01f4
1d9: e904
1da: 1c10
1db: 01f4
1dc: 1c10
1dd: 01f4
1de: 0000
1df: 0000
1e0: 0000
1e1: 0800
1e2: 0800
1e3: 0000
1e4: 0000
1e5: 0200
1e6: 0000
1e7: 0000
1e8: 0000
1e9: 0000
1ea: 0000
1eb: 0000
1ec: 0000
1ed: 0000
1ee: 0000
1ef: 0200
1f0: 0000
1f1: 0000
1f2: 0000
1f3: 0000
1f4: 0000
1f5: 0000
1f6: 0000
1f7: 0000
1f8: 0000

> Also, could you do a loopback test?
> Open capture and playback simultaneously, then
> set 0x78 register bit 12 = 1.
> It will record what codec received. It is to make sure
> there is no problem on Intel side.

Stereo playing works fine on the headphones
output, so I do believe that me being unable to get the
right channel to be played on the left speaker because
there is only a left (mono) speaker really is a codec
routing problem.

Regards,

Hans
