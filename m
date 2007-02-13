From: "Ondra Zahradnik" <ondra.zahradnik@gmail.com>
Subject: Re: snd_hda_intel and Asus F3Jv problem on 2.6.19
Date: Tue, 13 Feb 2007 20:21:44 +0800
Message-ID: <77c094930702130421l4831f805t5a46af5aa19be74e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>TonTon <tonton <at> bdefracte.org> writes:

>> Finally no combination works. I make further investigation with model
>> asus-laptop, but I think the problem is related to num_steps reported for
>> many mixer controls (even if it was working in kernel alsa version).
>> So no way to launch alsamixer to control volume.

> I've discovered the same problem with ASUS F3T notebook. snd-hda-intel loads ok
> (and seems to autodetect notebook as asus-laptop) but I get Invalid argument and
> hda_codec: num_steps = 0 for NID=0x15 in dmesg when trying to start
> alsamixer/amixer.

I've found the same problem with ASUS A6JE notebook. snd-hda-intel
loads well, sound card is recognised well, but when I try to run
alsamixer I get invalid argument error mesage and in dmesg is
hda_codec: num_steps = 0 for NID=0x15. Is here anything new about this
issue?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
