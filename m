From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: Modem support for ICH6 based laptop?
Date: Thu, 24 Nov 2005 05:01:16 +0200
Message-ID: <20051124030116.GB6056@tecr>
References: <1132791202.32481.22.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1132791202.32481.22.camel@SillyPuddy.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Josh Green <josh@resonance.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 16:13 Wed 23 Nov     , Josh Green wrote:
> I have an ASUS Z71V based laptop which has an Intel HDA sound system
> (uses snd-hda-intel).  This laptop also has a modem, which I have heard
> referred to as an ICH intel modem, but I'm not sure of the details.
> I've tried loading the snd-intel8x0m module, but it doesn't seem to do
> anything (no additional sound cards, output, etc).  I didn't find any
> matches when looking through the list of PCI IDs in the intel8x0m.c
> file.  Any ideas if this driver supports this modem, or could be made to
> support it? 

Not intel8x0m, there is HDA (High Definition Audio, or Azalia) bus and
modem, the driver is 'hda-intel'. Is your modem supported or not depends
on which kind of modem (modem codec) you have. Drop us content of file
'/proc/asound/card0/codec#1' and we will know answer.

BTW. http://linmodems.technion.ac.il and discuss@linmodes.org list are
useful places for "which modem driver" questions (codec#1 identification
will be needed anyway).

Sasha.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
