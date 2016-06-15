Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Wed, 15 Jun 2016 13:49:08 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20160615114908.GB31281@localhost.localdomain>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <1465686096-22156-8-git-send-email-henrik@austad.us>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1465686096-22156-8-git-send-email-henrik@austad.us>
Subject: Re: [alsa-devel] [very-RFC 7/8] AVB ALSA - Add ALSA shim for TSN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, henrk@austad.us, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Henrik Austad <haustad@cisco.com>, netdev@vger.kernel.org, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

Now that I understand better...

On Sun, Jun 12, 2016 at 01:01:35AM +0200, Henrik Austad wrote:
> Userspace is supposed to reserve bandwidth, find StreamID etc.
> 
> To use as a Talker:
> 
> mkdir /config/tsn/test/eth0/talker
> cd /config/tsn/test/eth0/talker
> echo 65535 > buffer_size
> echo 08:00:27:08:9f:c3 > remote_mac
> echo 42 > stream_id
> echo alsa > enabled

This is exactly why configfs is the wrong interface.  If you implement
the AVB device in alsa-lib user space, then you can handle the
reservations, configuration, UDP sockets, etc, in a way transparent to
the aplay program.

Heck, if done properly, your layer could discover the AVB nodes in the
network and present each one as a separate device...

Thanks,
Richard


--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
