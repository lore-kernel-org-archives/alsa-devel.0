From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: EMU1212m register dump
Date: Thu, 05 May 2005 17:48:33 +0100
Message-ID: <427A4E61.7000806@superbug.co.uk>
References: <1115310254.9901.42.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1115310254.9901.42.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>A Linux user with a 1212m allowed me to log in via ssh, and I loaded the
>(patched - see my previous post) emu10k1 driver.  No sound, but it's
>promising.  I played something with aplay and the bits showed up in the
>cache data registers, but the wavetable synth seemed to fail silently
>without allocating any voices.  Probably they disabled it (it's not
>mentioned in the datasheet).
>
>The IO registers confirm that it does not use the p16v chip - they
>appear to have modified the emu10k2 core to run at 44.1, 48, 96, and 192
>KHz.
>
>I suspect that the ADCs might be wired to the mysterious "EMU32" ports,
>rather than the EXTIN/EXTOUTs.  Probably the EXTIN/EXTOUTs are hardware
>limited to 16 bit ADC connections.
>
>1302 
>1303 #define A_FXBUS(x)      (0x00 + (x))    /* x = 0x00 - 0x3f FX buses */
>1304 #define A_EXTIN(x)      (0x40 + (x))    /* x = 0x00 - 0x0f physical ins */
>1305 #define A_P16VIN(x)     (0x50 + (x))    /* x = 0x00 - 0x0f p16v ins (A2 only) "EMU32 inputs" */
>1306 #define A_EXTOUT(x)     (0x60 + (x))    /* x = 0x00 - 0x1f physical outs -> A_FXWC1 0x79-7f unknown   */
>1307 #define A_FXBUS2(x)     (0x80 + (x))    /* x = 0x00 - 0x1f extra outs used for EFX capture -> A_FXWC2 */
>1308 #define A_EMU32OUTH(x)  (0xa0 + (x))    /* x = 0x00 - 0x0f "EMU32_OUT_10 - _1F" - ??? */
>1309 #define A_EMU32OUTL(x)  (0xb0 + (x))    /* x = 0x00 - 0x0f "EMU32_OUT_1 - _F" - ??? */
>1310 #define A_GPR(x)        (A_FXGPREGBASE + (x))
>1311 
>
>So, the next thing to try is to connect the FX buses to those EMU32 outs
>and see what happens.
>
>Anyway here's a dump of /proc/asound/1212m.
>
>Jame, any news from EMU on a hardware sample? ;-)
>
>Lee
>  
>
Probably the easiest way to test would be to use qlo10k1 and use the 
"sine wave" DSP test instruction" and just link it to all the possible 
outputs.
Then just use it interactively to narrow down which ports actually do stuff.

No news on any EMU hardware sample. :-(

James



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
