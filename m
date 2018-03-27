From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: No audio on Lenovo Miix 320
Date: Tue, 27 Mar 2018 10:48:14 -0500
Message-ID: <59eca166-888f-d211-8d35-d760786fbf8f@linux.intel.com>
References: <CAEw6ZytwPFpHskzAUJBtF9_MupiJ2obOx6n8sJ8Oo8gZZ4A1Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id EB3B526719A
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 17:48:16 +0200 (CEST)
In-Reply-To: <CAEw6ZytwPFpHskzAUJBtF9_MupiJ2obOx6n8sJ8Oo8gZZ4A1Mg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Freaky <freaky2000@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/27/18 5:56 AM, Freaky wrote:
> Hi there,
> 
> we're having some issues getting the audio working on a Lenovo Miix 320.
> 
> On some forums they say it should work after
> blacklisting snd_hdmi_lpe_audio. Have blacklisted this, and there's one
> audio card less now, but still no go unfortunately.
> 
> Currently running with 4.15.10 from Fedora 27.
> 
> It logs a lot of: "Audio Port: ASoC: no backend DAIs enabled for Audio
> Port" lines.

You need a UCM file or to set the mixers. This is a user-space 
configuration issue, the kernel is doing what it's supposed to do.

> 
> Any ideas on how to troubleshoot this? Saw similar problems in
> https://bugzilla.kernel.org/show_bug.cgi?id=96691 but this seems to be for
> another codec/DAI. Also, their system seems to be a Baytrail Atom, this is
> a Cherrytrail. Not sure if any of the patches are applicable.

the UCM or mixer settings is not related to the SOC but to the card name 
and codec capabilities. We share the same settings between Baytrail and 
Cherrytrail.

> 
> dmesg is attached.
> 
> I can patch, build and test kernels. Coding is another story however :).
> 
> Any help is appreciated.
> 
> Kind regards,
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
