From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sequencer timestamps for soft synth app
Date: Wed, 03 Jun 2009 17:02:01 +0200
Message-ID: <4A269069.2000506@ladisch.de>
References: <4A263A89.9020307@castro-design.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B656C243D2
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 17:01:54 +0200 (CEST)
In-Reply-To: <4A263A89.9020307@castro-design.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Glyn Adgie <glyn@castro-design.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Glyn Adgie wrote:
> I cannot find an ALSA function for getting a timestamp.

If you have a running queue, you can get timestamped events delivered to
your port by enabling it with snd_seq_port_info_set_timestamping() and
snd_seq_port_info_set_timestamp_queue().  (The events don't actually
need to come through that queue.)  See the source code of arecordmidi.


HTH
Clemens
