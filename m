From: David Lloyd <dmlloyd@tds.net>
Subject: DMIX and capture stream
Date: Fri, 2 Jan 2004 14:29:12 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401021421520.4466@tomservo.workpc.tds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm working on changing DMIX to allow clients to open the capture stream.  
But I've hit a bit of a block with how to proceed.  Since it would seem
that a slave snd_pcm_t can only be opened either for capture or playback,
it would seem to follow that one would need a second handle to be able to
open both ways.  Is that correct?

Based on this assumption, I added a 'scappcm' member to the u.dmix member 
of snd_pcm_direct_t.  This would be the handle used for capture stream 
opens.  It would not be shareable like the playback stream (at least not 
yet).  Is this a reasonable approach?

I was thinking about copying out the read routines from pcm_plugin.c and 
editing them to use u.dmix.scappcm for reading.  Will this approach work 
or will I have to make dramatic changes?  Is anyone here willing to take 
some time and check over my work, maybe point me in the right direction?

Thanks for the help.

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
