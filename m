From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Hammerfall (hdsp) initialization problem
Date: Tue, 27 Jul 2004 15:26:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407271926.i6RJQPeR009489@localhost.localdomain>
References: <s5hllh54dm0.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 27 Jul 2004 18:30:15 +0200."
             <s5hllh54dm0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>, Thomas Charbonnel <thomas@undata.org>, Tim Blechmann <TimBlechmann@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Jean-Marc Valin wrote:
>> 
>> > The problem is that you have to know the PCI pointer to call
>> > dma_alloc_coherent() correctly beforehand.  Otherwise you'll get only
>> > ZONE_DMA under 16MB region.
>> 
>> Still, there must be *something* that can be done, no? What are other
>> OSs doing about that? I mean, the card manual doesn't say "if you insert
>> this card after boot, it won't work", so I don't see why ALSA

actually, the manual for other OS'es *does* say that, at least it does
for the non-hotplugged devices like the original digi9652. i have
always assumed that the same problem would exist for hot-pluggable
devices too.

--p




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
