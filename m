From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB Audio device syncpipe error
Date: Thu, 9 Sep 2010 04:25:48 +0200
Message-ID: <20100909022548.GI7159@buzzloop.caiaq.de>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>
	<AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C6EC210388B
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 04:25:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 6275 kson <6275.kson@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 08, 2010 at 02:40:55PM -0500, 6275 kson wrote:
> up as an output device in Ubuntu's (10.4) sound preferences.  The device is
> working well with other OS's.
> 
> My syslog shows this error.
> 'cannot submit syncpipe for urb 0, error -90: internal error'
> 
> If someone could help me diagnose the source of the problem I would
> appreciate it very much.

Could you post the output of "lsusb -v", please?


Thanks,
Daniel
