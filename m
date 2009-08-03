From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Mon, 3 Aug 2009 11:12:44 +0100
Message-ID: <20090803101243.GA5959@sirena.org.uk>
References: <20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
	<20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A1918246CB
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 12:12:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 03, 2009 at 12:45:08PM +0530, Harsha, Priya wrote:

[Please don't top quote; it's not the normal policy for Linux lists
since it makes the discussion harder to follow.  Please also try to
configure your mail client to wrap lines at 80 columns for similar
reasons.]

> I tried but still finding the same issue...the probe function and the related functions are as follows... please let me know if you see any issues


> 	ret_val = snd_intelmad_pcm(card, intelmaddata);
> 	if (ret_val) {
> 		sst_err("snd_intelmad_pcm failed\n");
> 		goto free_allocs;
> 	}
> 
> 	ret_val = snd_intelmad_mixer(intelmaddata);
> 	if (ret_val) {
> 		sst_err("snd_intelmad_mixer failed\n");
> 		goto free_allocs;
> 	}
> 
> 	ret_val = snd_intelmad_jack(intelmaddata);
> 	if (ret_val) {
> 		sst_err("snd_intelmad_jack failed\n");
> 		goto free_allocs;
> 	}

The main difference I can see see between this and other drivers I can
see is the ordering of the jack creation - it's normally done earlier.
I'd suggest doing a contrast and compare with them, and also examining
what's going on in the code.
