From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH 4/4 v4] ALSA: usb-audio: Scarlett mixer
 interface for 6i6, 18i6, 18i8 and 18i20
Date: Tue, 4 Nov 2014 13:51:05 -0600
Message-ID: <20141104195104.GA9391@canonical.com>
References: <s5hd29ac9qn.wl-tiwai@suse.de>
 <1415055496-11151-1-git-send-email-chris.j.arges@canonical.com>
 <1415055496-11151-5-git-send-email-chris.j.arges@canonical.com>
 <s5hppd39sm8.wl-tiwai@suse.de> <5458D19D.7050206@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 47159260625
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 20:51:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5458D19D.7050206@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tobias Hoffmann <th55@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 02:16:13PM +0100, Tobias Hoffmann wrote:
<snip>
> @Chris:
> The original get_ctl_value (after cleanup:
> snd_usb_get_cur_mix_value) contained this:
> >        // quirk: write 2bytes, but read 1byte
> >        if ( (elem->index == 0x01)||  //  input impedance and
> >input pad switch
> >             ((elem->index == 0x0a)&&(elem->wValue < 0x0200))|| //
> >bus mutes
> >             (elem->index == 0x32)||(elem->index == 0x33) ) { // mux
> >                val_len = 1;
> >        }
> Is it removed(AFAICT) intentionally in your patches?
> The windows mixer software did read-back some values (but only after
> they had been written once, IIRC), and had this asymmetry that
> certain registers used 2-byte writes but 1-byte reads...
> I'm quite unsure about just reading 2 bytes, i.e. whether the device
> would actually return the correct values.
> OTOH, we should only hit the cache because of the zero-initialization(?).
> 
>   Tobias
>

Tobias,
I've notcied that the controls work just fine without this hack (at least on my 18i8);
however I can look more closely into this to see what the extra byte that's being read actually is. 
--chris
