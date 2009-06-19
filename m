From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: RFC: Jack-detection control elements on HD-audio
Date: Fri, 19 Jun 2009 14:21:26 +0200
Message-ID: <20090619122126.GA5785@tango.0pointer.de>
References: <s5hk538ejj4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BF2D10381B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 14:21:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk538ejj4.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

On Fri, 19.06.09 10:04, Takashi Iwai (tiwai@suse.de) wrote:

> Hi,
> 
> yet another thing I've worked recently on is a bit more generalized
> framework for jack-sense reporting for HD-audio.  This supersedes the
> existing jack-sense reporting via the input layer.  In addition, it
> gives the corresponding control elements.
> 
> For example, you'll have "Jack HP-Out" (or a bit more verbose like
> "Jack HP-Out at Ext Rear") control via control API as well as other
> mixer controls.  This can notify when a jack is plugged/unplugged.
> But, another big win is that you can read the current pin sense just
> by reading this element.
> 
> I think this is a sort of feature Lennart wanted for PA.
> Lennart, does it make sense?

Yes. I think it would. Also, if we can use the name of a control to
find the jack sensing control for it this would be great. I.e. if we
have a control "Headphone" and the Jack sensing control for it would
then be called "Headphone Jack" or so, this would be great! 

Right now the only way to identify the purpose of a mixer element is
by knowing it and going by the name. Would be good if that would be
made easy for jack sensing controls.

This also relieves us a bit from the little ugliness of having to
manage permissions for those input devices differently from other
input devices.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
