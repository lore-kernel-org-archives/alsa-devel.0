From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Date: Tue, 21 Apr 2009 08:34:02 +1000
Message-ID: <18924.63578.495727.152443@cargo.ozlabs.ibm.com>
References: <20090420225659.7b92a184@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090420225659.7b92a184@hyperion.delvare>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean Delvare writes:

> Takashi, please push this patch to Linus quickly, as this is blocking
> the removal of the legacy i2c binding model, which is scheduled for
> 2.6.30.

I really don't think you can remove it from Linus' tree at this stage
in the 2.6.30 cycle.  If it was going to be removed it should have
been removed in the merge window.  Removing it now has too much risk
of introducing regressions in my opinion.

I presume you have a development tree where you queue up commits for
the i2c subsystem for the next merge window.  I suggest you do the
removal there now (or whenever you like) and push it to Linus in the
next merge window.

Paul.
