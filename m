From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH 02/19] ALSA: ymu831: add device register
 definitions
Date: Thu, 17 Jan 2013 15:24:59 +0900
Message-ID: <20130117152459.305e658fa201766a85337267@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172704.256eccbb8412439455df14e7@linux-mips.org>
 <20130116131808.GA16235@sirena.org.uk>
 <20130117150006.ff5c6a69d29d0198a784c7ca@linux-mips.org>
 <20130117060247.GA20199@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130117060247.GA20199@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Jan 2013 15:02:48 +0900
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Jan 17, 2013 at 03:00:06PM +0900, Yoichi Yuasa wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > > +#define MCI_A_REG_A			0
> > > > +#define MCB_A_REG_AINC			0x80
> 
> > > All these definitions need to be namespaced.
> 
> > How should these change concretely?
> 
> Put a prefix in front of them.
> 

OK, I'll update them.

Thanks,

Yoichi
