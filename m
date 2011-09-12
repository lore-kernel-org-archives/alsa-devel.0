From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Determining the plugins being used?
Date: Mon, 12 Sep 2011 22:31:36 +0200
Message-ID: <4E6E6C28.1070009@ladisch.de>
References: <CAE3TgXGk9uaK0ESwUj2OGXKjBhRpi8tUgQXRT8GOMHLhX8ELGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 29BD72438C
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 22:32:08 +0200 (CEST)
In-Reply-To: <CAE3TgXGk9uaK0ESwUj2OGXKjBhRpi8tUgQXRT8GOMHLhX8ELGg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
> Is there a way to determine the plugins being used?

Not really.  snd_pcm_type() gives you the topmost plugin's type.


Regards,
Clemens
