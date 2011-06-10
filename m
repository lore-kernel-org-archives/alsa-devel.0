From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: omap-mcbsp: Do not attempt to change
 DAI sysclk if stream is active
Date: Fri, 10 Jun 2011 14:50:44 +0100
Message-ID: <20110610135043.GA22397@opensource.wolfsonmicro.com>
References: <1307711845-1636-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307711845-1636-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 04:17:25PM +0300, Jarkko Nikula wrote:
> Attempt to change McBSP CLKS source while another stream is active is not
> safe after commit d135865 ("OMAP: McBSP: implement functional clock
> switching via clock framework") in 2.6.37.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
