From: Daniel Mack <daniel@caiaq.de>
Subject: Re: no sound when using TV-OUT - fixed
Date: Sat, 14 Nov 2009 12:56:14 +0100
Message-ID: <20091114115614.GY14091@buzzloop.caiaq.de>
References: <4AFE86BC.4010404@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 46962103812
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 12:56:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AFE86BC.4010404@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Reiner <reiner1210@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 14, 2009 at 11:30:20AM +0100, Reiner wrote:
> I think I have fixed it
> 
> in the /dev directory I have done the following:
> 
> chmod ugo+rw dsp

In case you're using udev, the /dev folder is created dynamically, so
your change won't survive a reboot. 

Check the file permissions of the nodes again and see which group
ownership they have (most probably 'audio').

Then run 'sudo useradd -G <group> <youruser>'. Log out and back in again
to make this change effective. To check wheter it worked, type 'id' to
find out which groups your user is a member of.

HTH,
Daniel
