From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: FORWARD - RME Hammerfall HDSP 9652
Date: Tue, 16 Sep 2003 23:18:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <47692.217.128.131.141.1063747111.squirrel@www.undata.org>
References: <3F6499D5.1080306@notam02.no>
        <1063628552.1635.1.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1063628552.1635.1.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: markknecht@comcast.net
Cc: alsa-devel@lists.sourceforge.net, natasha.barrett@notam02.no
List-Id: alsa-devel@alsa-project.org

> Natasha is having email server problems and asked me to forward this to
> the list.
>
> - Mark
>
> On Sun, 2003-09-14 at 09:39, Natasha Barrett wrote:
>> For some time I have been trying to get the HDSP 9652 sound card
>> working under LINUX (with Pd).
>> Everything was fine in an old, slower machine. The new machine has
>> been impossible, and no-one appears to have had the same problems as
>> me. The closest I found was the thread from August about
>> firmware revisions. Maybe you can suggest something.
>>
>> I currently have rev. 100 of the firmware. Have you tried this?
>>
>> Here is a list of alsa & kernel versions tested and the errors they
>> give:
>>
>> 1. kernel 2.4.21-1.ll-acpi
>> 2. Alsa v 0.9.6
>>
>> Result: works OK for anything between 10 minutes to 10 hours and then
>> audio stops with input and output values equal levels. No error
>> message is given. Audio just stops. The machine may need rebooting 10
>> times before audio will resume. It appears random.
>>
>> 1. kernel 2.4.21-1.ll-acpi
>> 2. Alsa v 0.9.0rc6 (version that worked fine on old machine, can't run
>>  old kernel on new machine).
>>
>> Result: modprobe snd-hdsp seg faults.
>>
>> Have also tried alsa versions:
>> 0.9.4 -> made no sound at all.
>> 0.9.5 -> Made sound, but only at channel 3-7
>>
>> Is it worth trying to upgrade to firmare 101? Is there anyway
>> to do this under LINUX, or do I have to install Windows?
>>
>> Thanks for any suggestions.
>> Natasha Barrett
>>

Mark who forwarded your mail experienced similar problems (though they
occured at a much higher rate), and it appears using firmware 101 solved
them. I also know from RME that some of the first cards from the 9652
series were defective, and had to be sent back to the manufacturer. Did
you ever use the card under windows or mac os with success ?
If you choose to upgrade your firmware you'll have to find a windows box
for now, sorry. I'm planning to develop a linux tool to do this in the
next months, but don't expect anything soon.
You may also want to try the patches I posted to this list a few weeks
ago. They fix a few issues with the 9652 driver, notably enabling proper
operation of the matrix mixer code, and implementing the metering stuff. I
have a development hdspmixer (totalmix clone) version working with this
driver, feel free to email me if you need it.

Thomas





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
