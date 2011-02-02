From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] asoc: davinci: da830/omap-l138: correct
	cpu_dai_name
Date: Wed, 02 Feb 2011 18:51:58 +0300
Message-ID: <4D497D9E.9040201@mvista.com>
References: <1296658444-8836-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <1296658444-8836-1-git-send-email-vaibhav.bedia@ti.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, davinci-linux-open-source@linux.davincidsp.com, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Hello.

Vaibhav Bedia wrote:

> McASP1 is used on the DA830/OMAP-L137 platform for the codec.
> This is different from the DA850/OMAP-L138 platform which uses McASP0.

    I guess that in the subject you meant to type "da830/omap-l137"?

> This is fixed by adding a new snd_soc_dai_link struct.

> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

WBR, Sergei
