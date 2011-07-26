From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V5 2/3] ASoC: Add a DB1x00 AC97 machine
	driver
Date: Tue, 26 Jul 2011 15:39:55 +0100
Message-ID: <20110726143955.GH7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
	<1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 25, 2011 at 01:44:46PM +0200, Manuel Lauss wrote:
> Add a machine driver suitable for the AC97 part on the DB1000/DB1500/DB1100
> boards.
> 
> Run-tested on DB1500.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Since you've got both arch/ and sound/ changes in here I need an ack
from the MIPS maintainers for this one before I can apply it.
