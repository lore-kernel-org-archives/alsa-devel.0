From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: Q: How to detect which USx2y is connected?
Date: Tue, 13 Feb 2007 18:13:53 +0000
Message-ID: <45D1FFE1.9080808@rncbc.org>
References: <20070205065636.GA1652@elte.hu>	<45CDE6B9.80804@rncbc.org>	<23912.194.65.103.1.1171382877.squirrel@www.rncbc.org>	<200702131836.36010.annabellesgarden@yahoo.de>	<s5hire6c5jo.wl%tiwai@suse.de>
	<45D1FE83.7000301@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45D1FE83.7000301@rncbc.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rui Nuno Capela wrote:
> Takashi Iwai wrote:
>> At Tue, 13 Feb 2007 18:36:35 +0100,
>> Karsten Wiese wrote:
>>> Hi Rui,
>>>
>>> Am Dienstag, 13. Februar 2007 schrieb Rui Nuno Capela:
>>>> Hi Karsten,
>>>>
>>>> In my quest in completing us428control implementation, I'm now stumbling
>>>> on a fundamental question regarding the number of tracks/channel-faders
>>>> (per bank) each particular usx2y device supports. The question boils down
>>>> to what is the actual numeric value of the y in the actual usx2y model
>>>> name :)
>>>>
>>>> In practice, I need to know which usx2y model is actually connected.
>>>>
>>>> So, what is the best/deterministic way to detect (programmatically)
>>>> whether us428control is connecting to a US224 (y=4, as mine) _or_ a US428
>>>> (y=8, as yours) ?
>>>>
>>>> Is snd_hwdep_info_get_name() expected to be the most correct method?
>>> Yes, I fear. this gives the /proc/bus/usb/002/004 filename.
>>> I just did cat /proc/bus/usb/004/005 > x
>>> and check x with hexedit: the 1604 and 8001 is in there.
>>> I don't know how to portably interpret a read from
>>> /proc/bus/usb/004/005 though.
>> Note that /proc/bus/usb is deprecated on many distros...
>>
> 

And yes, the path returned from snd_hwdep_info_get_name(), which is atm
 '/proc/bus/usb/001/004', doesn't even exist on the system (opensuse
10.2; 2.6.20-rt3 SMP/HT)

So there must be another way...
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
