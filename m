From: Julien Bramary <julien.bramary@blueyonder.co.uk>
Subject: Re: How to Test my Driver
Date: Fri, 11 Aug 2006 01:42:15 +0100
Message-ID: <44DBD267.1070800@blueyonder.co.uk>
References: <44DAA852.3040402@blueyonder.co.uk> <s5hzmecwx2e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmecwx2e.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 10 Aug 2006 04:30:26 +0100,
> Julien Bramary wrote:
>   
>> Hello all,
>>
>> I am writing an alsa driver for a Micronas DAC on an embedded arm 
>> system. (I am still an Alsa beginner).
>> The device is now able to play wav with aplay and mp3 with madplay 
>> without too much trouble (pause-resume works etc).
>>
>> However, I'd like to know if there is a way to test the driver more 
>> extensively (at various sampling rates etc...).
>>     
>
> I usually try aplay with various wav files that are converted to
> different rates, channels and formats by sox or other tools.
> Also, using different buffer size and period size with aplay is
> recommended.
>
> For multiple channels, speaker-test is a good tool, too.
>
>
> Takashi
>
>   
Thank you Takashi,
I will use audacity to generate the adequate wav files and tweak the 
buffer and period sizes in aplay as you suggested.


Julien


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
