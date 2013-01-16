From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 18/19] ALSA: ymu831: add hwdep ioctl
Date: Wed, 16 Jan 2013 13:53:07 +0000
Message-ID: <20130116135307.GH16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116174429.c9f25228f247679ae7906f71@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116174429.c9f25228f247679ae7906f71@linux-mips.org>
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

On Wed, Jan 16, 2013 at 05:44:29PM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  include/uapi/sound/asound.h           |    3 +-
>  include/uapi/sound/ymu831.h           |   81 +++++
>  sound/soc/codecs/ymu831/ymu831.c      |  585 +++++++++++++++++++++++++++++++++
>  sound/soc/codecs/ymu831/ymu831_priv.h |    5 +-

Why are you adding ioctl() calls here?  What makes it impossible to
support whatever you're doing from standard APIs?
