From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp patch
Date: 15 Jun 2003 20:26:54 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055734014.2748.64.camel@Wizard.knechthome.com>
References: <E19RjsK-00057y-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19RjsK-00057y-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-06-15 at 19:42, Paul Davis wrote:
> >RME HDSP 9652 (Card #1)
> >Buffers: capture df000000 playback dee00000
> >IRQ: 17 Registers bus: 0xe8800000 VM: 0xe08e6000
> >Control register: 0x10080b3
> 
> You don't have the correct version of the driver. It would print:
> 
> RME Hammerfall HDSP 9652 (Card #1)
> Buffers: capture f7000000 playback f6e00000
> IRQ: 11 Registers bus: 0xfebb0000 VM: 0xf88af000
> Control register: 0x10080f9
> Control2 register: 0x800
> 
> notice the extra "Control2" register printout. 

Cool. Something to look for anyway....

15 minutes later.

Bingo! OK, so the new driver hadn't gotten moved to the right place. It
seems to be there now. I'm getting sound, but it's full volume and I
don't seem to be able to turn it down. (And I only have a few more
minutes before my kid goes to sleep. Or tries to...) ;-)

I have alsamixer up and running, and the volumes turned down to 6 and
it's still screaming loud. Is this like the old driver where the mixer
didn't work at all? Or have I not set the right things?

The other thing I notice is I only seem to be able to set 24 values in
my little script to set volumes. The driver I just replaced allowed me
to set all 26.

OK, so a lot of progress, but I need to be able to reduce the volume
badly!!!

What can I send you to see if it's my problem?

Also, please answer - do I need to set routing paths through the HDSP
FPGA to get the mixer working? Can you supply a script to do that if
it's necessary?

Thanks,
Mark



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
