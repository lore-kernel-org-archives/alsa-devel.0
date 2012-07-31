From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712 / AC97 probe causes regmap oops
Date: Tue, 31 Jul 2012 13:17:41 +0100
Message-ID: <20120731121740.GE4468@opensource.wolfsonmicro.com>
References: <CAOLZvyFUXpnvc2YXa6BqXh7GEtD4pA52L-=i6X6-rewom=MyYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAOLZvyFUXpnvc2YXa6BqXh7GEtD4pA52L-=i6X6-rewom=MyYw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 10:39:11AM +0200, Manuel Lauss wrote:
> Commit 38cbf9598feba97de9f9b43efa9153fd7c1a2ec9
> ("ASoC: core: Try to use regmap if the driver doesn't set up any I/O")
> causes an oops on boot when the wm9712 AC97 codec is probed.
> 
> Reverting it (or alternatively setting wm9712's codec::control_data to
> a random pointer) fixes it.

Please send a patch.
