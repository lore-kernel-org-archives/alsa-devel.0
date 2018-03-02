From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Fri, 2 Mar 2018 16:17:35 -0600
Message-ID: <20180302221735.u7cvvkkjgn3i2rgp@rob-hp-laptop>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
 <20180301193046.GJ12864@sirena.org.uk>
 <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
 <2ac828b2-04e1-4b5f-f4db-a543ad5e3535@redhat.com>
 <20180302121801.GE6255@sirena.org.uk>
 <bbe1b540-201a-bf6e-9008-0f8d5d4a2a9d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D223D267408
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 23:17:38 +0100 (CET)
Received: by mail-oi0-f46.google.com with SMTP id c83so8146184oib.1
 for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2018 14:17:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bbe1b540-201a-bf6e-9008-0f8d5d4a2a9d@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 02, 2018 at 01:58:53PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-03-18 13:18, Mark Brown wrote:
> > On Fri, Mar 02, 2018 at 10:32:25AM +0100, Hans de Goede wrote:
> > > On 01-03-18 23:35, Hans de Goede wrote:
> > 
> > > > It is not _that_ fragile, but I agree that it would be good to add
> > > > a comment about not moving the property-parsing to the codec driver.
> > 
> > > So one other solution which comes to mind here is to move the
> > > snd_soc_card_jack_new() call into the codec driver's
> > > rt5651_apply_properties() function (conditional on a jack src being
> > > set in the properties).
> > 
> > > This would make the machine driver code look like this:
> > > 
> > > 	props[cnt++] = PROPERTY_ENTRY_...
> > > 	props[cnt++] = PROPERTY_ENTRY_...
> > > 	props[cnt++] = PROPERTY_ENTRY_...
> > > 	props[cnt++] = PROPERTY_ENTRY_...
> > 
> > > 	ret = device_add_properties(codec->dev, props);
> > > 	if (ret)
> > > 		return ret;
> > 
> > > 	ret = rt5651_apply_properties(codec);
> > > 	if (ret)
> > > 		return ret;
> > 
> > > Which makes the ordering really clear without needing any
> > > comments.
> > 
> > It's still unusual to have something outside the driver trigger property
> > parsing, though the EXPORT_SYMBOL_GPL() would make that apparent.
> > 
> > > This will also make the jack-detect device-properties work with
> > > devicetree platforms without any changes to their platform code,
> > > which currently is not the case since the non Intel platform-code
> > > does not call snd_soc_component_set_jack().
> > 
> > What makes you claim that?  Any board with jack detection wired up will
> > call that function.  Not all boards have that configured of course but
> > there's absolutely nothing Intel specific about that interface.
> 
> Right I'm not claiming the interface is Intel specific, what I'm trying
> to say is that the need for some code outside of the codec driver
> to create the jack means that adding jack-support to DT platforms
> cannot be done through just adding DT properties (once this patch
> is merged), it will still require platform code changes.
> 
> That is fine, I was just thinking it would be convenient if DT
> platforms could lift on the jack-detect work being done for
> the rt5651 driver now with just some DT changes and no other
> changes required.
> 
> > > Thinking more about this I believe that doing the
> > > snd_soc_card_jack_new() call inside the codec driver based on
> > > device-properties is a better solution then doing it in the
> > > machine driver.
> > 
> > No, that's really not a good idea.  Any jacks in the system are part of
> > the system specific wiring, they're not something that's intrinsic to
> > the CODEC.  Even with fairly basic setups you've got options like having
> > a headset jack or separate microphone and headphone jacks.
> 
> OK, so if doing the jack creation in the machine-driver / platform
> code is by design and you want to keep things that way, then I
> assume that what needs changing for v3 of this patch is:
> 
> 1) Split the patch in separate codec + machine-drv patches
> 2) Add comments to make the ordering requirements clear to
> both the codec- and machine-driver.
> 
> Correct?

And split bindings to separate patch please.

Rob
