From: alsa-devel@robdye.net
Subject: Re: Minor bug(s) in hdsp.c (RME HDSP driver)
Date: Mon, 21 Jul 2003 15:10:53 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1058825453.3f1c64ed6de45@scorpio.lunarpages.com>
References: <E19dvjH-0001Qh-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19dvjH-0001Qh-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Quoting Paul Davis <paul@linuxaudiosystems.com>:

> >I also think that the behaviour of hdsp_set_rate() should change. If the 
> >card is set to AutoSync, and there is no input signal, hdsp_set_rate() 
> >will fail on line 888. In this case, I think the proper behaviour would 
> >be to set the card in Master mode with the given rate.
> 
> seems sensible.
> 

I disagree.  If the card is set to AutoSync and there is no input
signal anywhere, this would probably be a problem with cabling or routing
somewhere.  From an end-user perspective, I would want giant red lights 
flashing on my screen telling me things are wrong.  The last thing I
would want is for a low-level software component to silently switch to
master mode.  This would likely cause sample-slipping with some other
piece of hardware, and if the sample rates are close, this may very well
not be detected by cursory audio monitoring (and only noticed after you
have the "perfect take" down).

Of course, if the application knows about slave synchronization, I
would expect it never to call a function to set the sample rate -- only
check the rate.  But a lot of app's don't work this way.  I've played
back a 44.1kS/s file when externally synced to 48kS/s and it comes out
too high/fast.  This is usually pretty easy to detect by listening, so
it's not a horrible problem, but some sort of warning would be better
(naturally this depends on the application, but it requires that the
library return some sort of abnormal status in this case).

The behavior that seems best to me would be to return an error when
1) AutoSync is selected and 2) the sample rate given is not within 400ppm
of the current external sync or there is no valid external sync signal
Then, let the application decide on the policy to implement in these
cases.

Of course, I'm not sure how well this meshes with the overall
ALSA system model and "consumer" style sound cards.  It's just that
sample rate timing/sync (and the associated problem of jitter) is
probably the single biggest issue in distribution of digital audio 
in a professional environment, so this is my USD2*10E-2.

--Rob Dye



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
