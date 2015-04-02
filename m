From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4271: Increase delay time after
 reset
Date: Thu, 2 Apr 2015 09:15:57 -0500
Message-ID: <alpine.DEB.2.10.1504020915200.13828@heelrod-desktop>
References: <1427962660-23517-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1427962660-23517-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: brian.austin@cirrus.com, patch@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


On Thu, 2 Apr 2015, pascal.huerst@gmail.com wrote:

> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> The delay time after a reset in the codec probe callback was too short,
> and did not work on certain hw because the codec needs more time to
> power on. This increases the delay time from 1us to 1ms.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
Thanks for the patch.

Acked-by: Brian Austin <brian.austin@cirrus.com>
