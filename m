From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [lack of] dynamic detection/loading of modules
Date: 04 Mar 2003 19:01:24 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046833285.28937.243.camel@cmn37.Stanford.EDU>
References: <E18oElA-0005cD-00@sc8-sf-list1.sourceforge.net>
	<1046378100.22559.23.camel@cmn37.Stanford.EDU>
	<s5hptpcihlv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptpcihlv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Ivica Bukvic <ico@fuse.net>, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > >lists about this and to do it cleanly it would be nice to have available
> > > >in /proc/asound the list of modules currently loaded. That is not
> > > >available today (I think Takashi said he might add that)."
> > > 
> > > cat /proc/modules | grep '^snd'
> > 
> > This relies in an (AFAIK) unenforceable convention (all modules that
> > start with "snd" are alsa modules). I think the information has to come
> > from within the alsa driver, or from some place that actually knows that
> > the module _is_ an alsa module. IMHO a name is not enough. 
> 
> ok, i added the code.
> the cvs version shows the list of modules on /proc/asound/modules.

Thanks! I started working on differentiating in the alsasound alsa
startup script between a full start (all modules are loaded when
alsasound executes) and a partial start (some of the modules are already
loaded when alsasound executes and it has to load the rest). 

The first naive question is: do we actually need to differenciate?
Apparently modprobe is happy to be given the name of a module that is
already loaded, as far as I can tell it does not try to load it again
(man modprobe does not say anything about this case that I can see). 

Apparently we could just dispense with the [ -d /proc/asound ] test in
alsasound and always load (or reload) the modules... or maybe just print
a warning when part of alsa has already been started before alsasound
executes. Surely it cannot be that easy :-) What am I missing?

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
