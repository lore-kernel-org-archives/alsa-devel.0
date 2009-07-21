From: Christopher Arndt <chris.arndt@web.de>
Subject: Re: pyalsa: synchronizing queue with MIDI clock events
Date: Tue, 21 Jul 2009 18:20:46 +0200
Message-ID: <4A65EADE.70007@web.de>
References: <4A607468.7010300@web.de> <4A65C370.3030205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id C128624405
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 18:20:46 +0200 (CEST)
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0A28210CE2C27
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 18:20:46 +0200 (CEST)
Received: from [78.34.98.189] (helo=minimax.paddyland.lan)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MTI57-0006bg-00
	for alsa-devel@alsa-project.org; Tue, 21 Jul 2009 18:20:45 +0200
In-Reply-To: <4A65C370.3030205@ladisch.de>
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

Clemens Ladisch schrieb:
> Christopher Arndt wrote:
>> What is a sensible number of ticks to take
>> into account for measurement?
> 
> Large enough that you get a stable average, but small enough that you
> can detect actual changes.

I figured out that much on my own :) I was just wondering if anybody had
already experimented with this...

> You can tell ALSA to timestamp all events that are received; just call
> the snd_seq_port_info_set_timestamping() function and set a queue that
> is running, then you'll get the queue's current time in each event.
> This isn't implemented in pyalsa, but you can set this for a specific
> connection with the queue, time_update, and time_real parameters of the
> connect_ports function.

I'll look into this.

Many thanks for your comments!

Chris
