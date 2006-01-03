From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: re: Envy24control -changes on screen
Date: Tue, 3 Jan 2006 22:06:40 +0000
Message-ID: <200601032206.40446.gineera@aspect135.co.uk>
References: <200512162315.43124.gineera@aspect135.co.uk> <s5hhd8mrfgu.wl%tiwai@suse.de> <s5hy81yzji5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy81yzji5.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 02 January 2006 16:23, you wrote:
> At Mon, 02 Jan 2006 13:17:53 +0100,
>
> I wrote:
> > > > Also, I got many compile warnings after your patch.  Could you fix
> > > > them, too?
> > >
> > > I have no warnings at all (otherwise the patch would not have been
> > > submitted). Can you list them and I will have a go.
> >
> > I got the following from gcc-4.0.2 (prerelease).
> >
> > envy24control.c: In function 'create_inputs_mixer':
> > envy24control.c:290: warning: unused variable 'drawing'
> > envy24control.c:289: warning: unused variable 'frame'
> > envy24control.c: In function 'create_pcms_mixer':
> > envy24control.c:344: warning: unused variable 'drawing'
> > envy24control.c:343: warning: unused variable 'frame'
> > envy24control.c: In function 'create_hardware':
> > envy24control.c:1329: warning: unused variable 'vbox2'
> > envy24control.c: In function 'create_outer':
> > envy24control.c:1937: warning: unused variable 'hbox'

ConfirmI have checked -all are unneccessary definitions left as a result of 
moving sections of code.  Presumably these have been deleted.

> > envy24control.c: In function 'main':
> > envy24control.c:2063: warning: type defaults to 'int' in declaration of
> > 'chanwidth'
> > envy24control.c:2064: warning: type defaults to 'int' in declaration of
> > 'fixwidth'

Is 'const' not accepted?  The intention is to ensure the value cannot be 
changed during program execution.

> OK, I fixed them by myself.  Now your patch is on CVS.
> Thanks.
>
>
> Takashi

Thanks to you also.
Will this result in envy24control version number being raised?  It has been at 
0.5.0 since at least alsa1.0.8?

Alan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
