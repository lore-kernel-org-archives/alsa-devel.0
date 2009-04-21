From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Date: Tue, 21 Apr 2009 11:29:21 +0200
Message-ID: <20090421112921.373fae89@hyperion.delvare>
References: <20090420225425.2a150a4f@hyperion.delvare>
	<1240261492.4632.21.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <1240261492.4632.21.camel@johannes.local>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

Hi Johannes,

On Mon, 20 Apr 2009 23:04:52 +0200, Johannes Berg wrote:
> On Mon, 2009-04-20 at 22:54 +0200, Jean Delvare wrote:
> > The legacy i2c binding model is going away soon, so convert the AOA
> > codec drivers to the new model or they'll break.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Tested-by: Johannes Berg <johannes@sipsolutions.net>
> > Tested-by: Andreas Schwab <schwab@linux-m68k.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > ---
> > Takashi, please push this patch to Linus quickly, as this is blocking
> > the removal of the legacy i2c binding model, which is scheduled for
> > 2.6.30.
> 
> Have you taken care of snd-powermac similarly?

Yes I did, see my patch "keywest: Convert to new-style i2c driver" to
the alsa-devel and linuxppc-dev mailing lists:
http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070884.html

Would you be able to test this patch? This would be very welcome. I can
resend it to you if it helps.

Thanks,
-- 
Jean Delvare
