From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: cs46xx multi or single threaded
Date: Fri, 1 Mar 2002 11:50:02 -0800
Message-ID: <20020301115002.A908@porky>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
Cc: dsolomo1@main.rr.com
List-Id: alsa-devel@alsa-project.org

David Solomon wrote:
> Is the module for the Hercules Game Theatre XP multithreaded
> or will it only work in a single application at a time?

    Multithreading and mixing are separate issues. Bascially, 
multithreading
allows a single application to run multiple processes, hopefully each
on a separate CPU to give a performance boost.
    Mixing takes multiple sound sources and mixes them into a single
stream, which is what you want to play sounds from multiple apps. I
tested the cs46xx driver just now using aplay, and each instance would
wait until the soundcard was free before playing the file (ie, no
mixing is available). Your best bet would be to go with something like
ESD (for Gnome environments) or arts (for KDE environments).
    Anybody please correct or clarify anything I said. I've only begun
playing with ALSA, so there may be other (better) options I'm not aware of.


-- Peter Heatwole
"Murphy was just a well known pessimist."
 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
