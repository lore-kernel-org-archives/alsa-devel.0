From: Fred Gleason <fredg@salemradiolabs.com>
Subject: Re: Mixer sanity
Date: Sat, 5 Jun 2004 23:46:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406052346.56150.fredg@salemradiolabs.com>
References: <1086443486.3656.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1086443486.3656.17.camel@localhost.localdomain>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Owen Fraser-Green <owen@discobabe.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 05 June 2004 09:51, Owen Fraser-Green wrote:

> Now, I know an envy24mixer exists to make life easier for me but surely
> it would be a bit nicer if the mixer interface provided a more
> consistent abstraction. In my situation, I want my software to be useful
> without a screen so the envy24mixer is out of the question. The only
> other solution, therefore, is for me to provide a map for every sound
> card which ALSA supports.

The problem with providing an 'abstraction' is that a model that works well 
for one class of application may be totally inappropriate for another.  This 
was one of the fundamental weaknesses of the original OSS API -- for example, 
it worked well enough for many of the simple 'stereo' cases, but tended to 
fall apart for multitrack work.  Different models of sound card are -- well 
-- different, and I think that all ALSA can reasonably be expected to do is 
expose the various features through the API so they can be utilized.

I quite sympathize with your desires here however, having struggled with the 
same issues in trying develop ALSA support for Rivendell 
[http://www.salemradiolabs.com/rivendell/], which is heavily dependent upon 
mixer operations.  I've finally come to the conclusion that the only sane way 
to provide this is to implement my own 'virtual' mixer, exporting the 
resulting output channels as JACK ports.  That way, users can connect the 
ports to whatever sources or destinations (be they ALSA ports or whatever) 
according to their own needs and the capabilities of their sound hardware.

Cheers!


|-------------------------------------------------------------------------|
| Frederick F. Gleason, Jr. | Director of Broadcast Software Development  |
|                           |             Salem Radio Labs                |
|-------------------------------------------------------------------------|
|                     Innovation is hard to schedule.                     |
|                                       -- Dan Fylstra                    |
|-------------------------------------------------------------------------|



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
