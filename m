From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ALSA: pcm: add IEC958 channel status
	update
Date: Wed, 2 Dec 2015 19:01:54 +0000
Message-ID: <20151202190154.GE8644@n2100.arm.linux.org.uk>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
 <1449066126-19431-2-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A80DF26509E
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 20:01:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449066126-19431-2-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 02, 2015 at 03:22:04PM +0100, Moise Gergaud wrote:
> Add a helper to update only the IEC958 channel status sampling freq and
> word length parameters from an ALSA snd_pcm_runtime structure, taking
> account of the sample rate and sample size.

What's also missing is an explanation of why this change is needed.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
