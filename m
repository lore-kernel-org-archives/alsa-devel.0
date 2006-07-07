From: Ben Williamson <ben.williamson@greyinnovation.com>
Subject: Re: [RFC] g_midi: New USB MIDI Gadget class driver.
Date: Fri, 07 Jul 2006 10:37:50 +1000
Message-ID: <44ADACDE.3040404@greyinnovation.com>
References: <44ACA882.7090209@greyinnovation.com>
	<20060706092715.GA13194@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060706092715.GA13194@turing.informatik.uni-halle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: David Brownell <david-b@pacbell.net>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> You need something like this:
> 	depends on SND
> 	select SND_RAWMIDI

Thanks, will do.

>> +	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1, THIS_MODULE, 0);
> 
> Other ALSA drivers have module options for index and id.

How's this?

static int index = SNDRV_DEFAULT_IDX1;
static char *id = SNDRV_DEFAULT_STR1;

module_param(index, int, 0444);
MODULE_PARM_DESC(index, "Index value for the USB MIDI Gadget adapter.");
module_param(id, charp, 0444);
MODULE_PARM_DESC(id, "ID string for the USB MIDI Gadget adapter.");

	card = snd_card_new(index, id, THIS_MODULE, 0);

I see lots of drivers with arrays for those, but I think I can use the excuse that
there is at most once instance of gmidi. As far as I can tell, the gadget subsystem
only handles one udc interface, at least for now.

Thanks for the feedback, I'll post another version when I can incorporating all the
suggestions.

Cheers,

- Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
