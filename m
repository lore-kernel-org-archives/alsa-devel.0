From: Paul Davis <pbd@Op.Net>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 17:25:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203250325.WAA27492@renoir.op.net>
References: <Pine.LNX.4.33.0203241858150.9245-100000@mcmillan.cadence.com>
In-Reply-To: Your message of "Sun, 24 Mar 2002 19:06:54 PST."
             <Pine.LNX.4.33.0203241858150.9245-100000@mcmillan.cadence.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ken McMillan <mcmillan@cadence.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>Oh -- thanks a lot for the quick answer! But then I guess I'll
>rephrase the question: Why would I get xruns with "plughw", but not
>with "hw"?

2 possibilities readily spring to mind:

  1) the plughw device is causing more code to be run, possibly
     causing timing issues

  2) a bug in the plughw code

what period size and number of periods are you using?
