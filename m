From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] sound/soc/fsl/fsl_ssi.c: let check zero instead of
 check NO_IRQ
Date: Thu, 26 Sep 2013 18:40:00 +0800
Message-ID: <52440F00.702@asianux.com>
References: <523FB47C.8010800@asianux.com> <523FB6F4.60803@asianux.com>
 <523FB735.2060906@asianux.com> <20130926102914.GG19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130926102914.GG19304@sirena.org.uk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, lgirdwood@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

On 09/26/2013 06:29 PM, Mark Brown wrote:
> On Mon, Sep 23, 2013 at 11:36:21AM +0800, Chen Gang wrote:
>> NO_IRQ may be defined as '(unsigned int) -1' in some architectures
>> (arm, sh ...), and either may not be defined in some architectures
>> which can enable SND_SOC_FSL_SSI (e.g. allmodconfig for arc).
> 
> Applied, thanks.
> 

Thank you too.  :-)

-- 
Chen Gang
