From: Gerd Knorr <kraxel@suse.de>
Subject: Re: Problem with Avermedia 771
Date: Thu, 21 Oct 2004 13:43:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041021114311.GA2190@bytesex>
References: <s5hwtxlh0wg.wl@alsa2.suse.de> <Pine.HPX.4.33n.0410210908100.7031-100000@studcom.urz.uni-halle.de> <s5hlle0gzcq.wl@alsa2.suse.de> <20041021101818.GA1182@bytesex> <s5hhdoogxuj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhdoogxuj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@suse.cz>, Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> That's the reason why I suggested the second way in my earlier post:
> 
> We prepare two pci_id tables, one for the whitelist and another for
> the default ids.  Only the former is exported.
> 
> When the module option is given, the latter id is registered while
> usually the fomer is used.

Yep, that should make the correct ID list visible to hotplug ...

  Gerd



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
