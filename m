From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ALSA: ASoC: Fix wrong param when
	call	snd_soc_test_bits
Date: Sat, 27 Sep 2008 17:33:02 +0100
Message-ID: <20080927163300.GA3225@sirena.org.uk>
References: <1222519396-6916-1-git-send-email-linuxzsc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1222519396-6916-1-git-send-email-linuxzsc@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 27, 2008 at 08:43:16PM +0800, Richard Zhao wrote:

> Fix wrong param when call snd_soc_test_bits in function dapm_mux_update_power.

So...  This patch doesn't actually do what the changelog entry here
says: the arguments to snd_soc_test_bits() remain the same before and
after your change.

> -		if (!path->name || ! e->texts[val])
> +		if (!path->name || !e->texts[mux])
>  			continue;

What this is actually doing is changing the enum text examined to be
indexed by mux (the value of the enumerated control) rather than val
(the bitmask in the register).  This looks like a good change but I want
to double check with a test system.
