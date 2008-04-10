From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Monotonic timestamps
Date: Thu, 10 Apr 2008 16:15:13 +0200
Message-ID: <20080410141513.GA5852@tango.0pointer.de>
References: <20080409213602.GA2589@tango.0pointer.de>
	<47FDBBC1.1030500@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 30E29244BA
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 16:15:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47FDBBC1.1030500@joow.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pieter Palmers <pieterp@joow.be>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10.04.08 09:03, Pieter Palmers (pieterp@joow.be) wrote:

> > I find it very strange that ALSA just switches to monotonic timestamps
> > just like that, anyway. Programs written for wallclack timestamps will
> > break if they run on a system where ALSA uses monotonic timestamps!
> > 
> > There's a function missing that enables monotonic timestamps
> > explicitly, or at least one that can be used to query if they are
> > monotonic or not.
> The clean solution would (IMHO) be to have ALSA provide a function to 
> obtain 'current time', thereby making the timestamp system 
> self-contained. Maybe it already does...

This wouldn't help much since timestamps might also come from other
libraries. i.e. being able to relate timestamps from ALSA with
timestamps from the application itself is not enough. They also need
to be relatable to timestamps from other code, which might not
necessarily be linked against ALSA.

i.e. think of gstreamer that uses timestamps attached to each video
frame. Do you really expect gst to move their timestamp source over to
ALSA just because one of the plugins for gst supports ALSA?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
