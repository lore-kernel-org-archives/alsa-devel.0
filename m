From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Update: emu1212m
Date: Tue, 11 Jul 2006 00:06:55 +0100
Message-ID: <44B2DD8F.5070205@superbug.co.uk>
References: <44951964.9020509@superbug.co.uk> <44A4530C.6040007@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44A4530C.6040007@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> James Courtier-Dutton wrote:
>> Hi,
>>
>> This is just a quick note to say that I have made some progress with the
>> alsa support for emu1212m.
>> Summary:
>> If one cold boots to windows, and then warm boots to linux, I have
>> managed to get SPDIF out working on the emu1212m.
>> This is good news, because I have managed to determine the final bit of
>> work required to get the emu1212m working in Linux.
>> The emu1212m has a FPGA on it.
>> 1) The FPGA array is filled with the netlists.
>> 2) The FPGA now has registers that can be read and written to switch
>> features on and off. E.g. spdif out or adat out.
>>
>> Now, I have done a lot of the work for step 2. I just need to work out
>> how to do step 1 now.
>> Step 1 happens on cold boot, and survives a warm boot.
>> Step 2 is already understood in the Linux driver.
>>
>> Summary:
>> TODO: Step 1.
>>
>> James
>>
> 
> Here is a small update. I have now completed (1) and (2), but a new
> problem remains.
> (3) The samples are not actually getting from the DSP to the SPDIF unharmed.
> 
> I am making further investigations into this, but no luck so far.
> 
> James

I received a very welcome email today. :-)
It contained some datasheets for the emu1212m FPGA from emu.com
themselves. :-)

I have now managed to get SPDIF output working from the emu1212m SPDIF
out to a SPDIF capture card in a different PC. The samples appear to be
unharmed. I have "speaker-test -c2 -tsine -Dfront" outputting samples
through the emu1212m. A sine wave then appears on the input of another
PC with an SPDIF capture card. I have not yet verified if the samples
are being interpolated or not.

The datasheets should give me enough information in order to get full
192kHz Audio capture and playback working, but that will take a rather
large rework of the snd-emu10k1 driver. For example, 48kHz stereo uses 2
FX_BUS channels, 96kHz mono uses 4, 192kHz uses 8!
The snd-emu10k1 driver is currently only set up to output 48kHz stereo
using 2 FX_BUS channels.

So, initially, I will only be implementing support for SPDIF and DAC/ADC
inputs/outputs at 48kHz.

My code needs a lot of clean up now, but I hope to be checking it in to
hg this weekend. :-)

Cheers

James


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
