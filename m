From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: ALSA sequencer changes?
Date: Mon, 15 Dec 2003 02:03:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312150200.38251.plcl@telefonica.net>
References: <E1AVNWF-00073D-OC@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1AVNWF-00073D-OC@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ryan Pavlik <rpav@mephle.com>
List-Id: alsa-devel@alsa-project.org

Ryan Pavlik wrote:
> Hrm, I've recently updated ALSA after a few weeks of inactivity, and
> suddenly I'm not getting MIDI events from simple code that previously
> worked.  I don't see any alsa-devel messages about changes, but I
> apparently missed the PCM API change notice.  In addition to the more
> complex library, I tried my test code which you can find here:
>
>     http://ogmo.mephle.org/test-alsa.c
>
> The problem isn't getting 0's for time (got that one sorted awhile
> back, but never integrated the fix)---the problem is I'm not getting
> anything.
>
> Anyhow, just wondering what's new or different, or if it's something
> else I missed.

No problems here with 1.0.0rc2. Your test reports events and times like  
before. Try using other client/port, check your cables, interfaces, etc...

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
