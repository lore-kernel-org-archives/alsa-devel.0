From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: kernel-2.5.72: /proc/asound/dev missing
Date: Fri, 20 Jun 2003 17:04:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306201702230.9621-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0306201451480.27630-100000@iua-mail.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306201451480.27630-100000@iua-mail.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten De Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Jun 2003, Maarten De Boer wrote:

> 
> > You have to rerun snddevices script available in the alsa-driver package
> > (utils subdirectory). The dynamic proc devices were removed on request of
> > 2.5 kernel developers.
> 
> Ok. It would have been nice to find this information in the kernel 2.5.72
> Documentation.
> 
> It's a bit strange though that it is necesary to download the alsa-driver
> package when the driver itself is already included in the kernel.. I'd say
> that for a 2.5.x user, it should be sufficient to download alsa-lib only
> in order to run alsa applicatins.. Maybe the snddevices script should be
> included with the kernel (I am not sure if there is a place for that..)
> or with the alsa library even?

Yes, the inclusion was a bit ommited. I will include the snddevices script 
in my next ALSA update for 2.5 kernels as linux/scripts/MAKEDEV.alsa with 
an appropriate note in the documentation.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
