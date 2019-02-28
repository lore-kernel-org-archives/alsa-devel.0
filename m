From: Timur Tabi <timur@kernel.org>
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Date: Thu, 28 Feb 2019 08:33:37 -0600
Message-ID: <ab0a0d6c-4905-328c-0e22-931c045ed8d9@kernel.org>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
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
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 2/27/19 11:56 PM, S.j. Wang wrote:
> cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
> should not be in the supported format list.
> 
> Signed-off-by: Shengjiu Wang<shengjiu.wang@nxp.com>

Is the device capable of accepting 32-bit samples, even if it downgrades 
it to 24-bit internally?  If so, then maybe SNDRV_PCM_FMTBIT_S32_LE 
should stay.
