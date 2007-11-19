From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Strange bug in .asoundrc ??
Date: Mon, 19 Nov 2007 16:43:48 +0100
Message-ID: <1195487028.2251.1222141113@webmail.messagingengine.com>
References: <47416E4D.3050207@loria.fr>
	<1195482005.19167.1222125449@webmail.messagingengine.com>
	<4741A665.1030600@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 12F81248D1
	for <Alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 16:43:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4741A665.1030600@loria.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dominique Larchey-Wendling wrote:
>  > It appears this behaviour is by design.
> 
> Ok so this is not a bug but a feature ;-)
> However, it is not specified in the doc that alsa-lib makes a semantic 
> distinction between the types of objects

If a somewhat complete documentation existed, it would certainly mention
this.

> in the alisp language.

The configuration language is not alisp.

> What is strange is that the same function is called in alsa-lib to
> expand hw:0 whether it is prefixed with "ctl" or "pcm" :
> 
> snd_config_search_definition(root, "ctl", name, &ctl_conf);
> 
> and
> 
> snd_config_search_definition(root, "pcm", name, &pcm_conf);

This function is called with a string like "tata" and returns the string
"hw:0" (it would return the compound node {type hw card 0} when it would
be called with "hw:0").

In the PCM code, it is the following recursive call of
snd_pcm_open_noupdate() that causes the extra lookup to happen.

> but my question was more why is it designed this way ?

Well, "designed" may be too strong a word; it implies that somebody
actually thought about it.  :-)

I'd guess that this functionality was never needed for any device type
except PCM because there aren't any plugins that could be used in place
of "hw".


Regards,
Clemens
