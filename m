From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: HDA codec graphing
Date: Fri, 18 Jan 2008 08:39:07 -0200
Message-ID: <5f52f6d70801180239x4be6c132s55d222e1c3d391cf@mail.gmail.com>
References: <5f52f6d70801170424o4682381fhc12416125a1b66a8@mail.gmail.com>
	<s5hwsq8ecgt.wl%tiwai@suse.de>
	<5f52f6d70801171018g334caca6k6d7bd49b9b1ef2@mail.gmail.com>
	<1200630493.5011.141.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 465BE24851
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 11:39:09 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so695964rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 02:39:07 -0800 (PST)
In-Reply-To: <1200630493.5011.141.camel@razman.gruemaster.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Jan 18, 2008 2:28 AM, Tobin Davis <tdavis@dsl-only.net> wrote:

>  I ran this on my home system (Intel DP965LT - STAC9227).  Attached is the
> graph to add to your samples.

Could you send me the subdevice ID and the codec file? We store the
samples in codec file format (instead of the generated ps/svg/png
files).


>  I also am submitting the first (of possibly many) patches.  This one will
> also look in the $PWD for the codecgraph.py file, so users who don't wish to
> install this can just download and run it in place.
>
>  I noticed a few output errors as well:
>
>  6: Unknown item: No Modem Function Group found
>  10: Unknown item: Default PCM:
>  But as I am not yet familiar with python, I'd like to just report these for
> now.

Thanks. In fact the tool is Eduardo's, I added the wrapper shell
instead of building that functionality into the Python script exactly
because I'm not familiar with Python as well, but I though this script
was a good excuse to learn it ;) So eventually (soon, I hope) I'll
change the main script to pipe the output directly into graphviz and
get rid of the wrapper.
