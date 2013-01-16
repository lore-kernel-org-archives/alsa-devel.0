From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/19] ALSA: ymu831: add device register
 definitions
Date: Wed, 16 Jan 2013 13:18:09 +0000
Message-ID: <20130116131808.GA16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172704.256eccbb8412439455df14e7@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116172704.256eccbb8412439455df14e7@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2013 at 05:27:04PM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

Please follow the patch submission process in SubmittingPatches.

> + * Module	: mcdefs.h
> + * Description	: MC device definitions
> + * Version	: 1.0.1	Dec 18 2012
> + *
> + * This software is provided 'as-is', without any express or implied
> + * warranty.	In no event will the authors be held liable for any damages
> + * arising from the use of this software.
> + *
> + * Permission is granted to anyone to use this software for any purpose,
> + * including commercial applications, and to alter it and redistribute it
> + * freely, subject to the following restrictions:
> + *
> + * 1. The origin of this software must not be misrepresented; you must not
> + *	claim that you wrote the original software. If you use this software
> + *	in a product, an acknowledgment in the product documentation would be
> + *	appreciated but is not required.
> + * 2. Altered source versions must be plainly marked as such, and must not be
> + *	misrepresented as being the original software.
> + * 3. This notice may not be removed or altered from any source distribution.

It's not entirely clear to me that this is GPL compatible... 

> +#define MCI_A_REG_A			0
> +#define MCB_A_REG_AINC			0x80

All these definitions need to be namespaced.
