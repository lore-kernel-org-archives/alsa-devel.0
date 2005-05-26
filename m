From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.12-rc3-mm3: ALSA broken ?
Date: Thu, 26 May 2005 11:55:57 -0400
Message-ID: <1117122958.6261.18.camel@mindpipe>
References: <20050504221057.1e02a402.akpm@osdl.org>
	 <1115510869l.7472l.0l@werewolf.able.es>
	 <1115594680l.7540l.0l@werewolf.able.es>
	 <20050526001828.0b3959f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050526001828.0b3959f6.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-05-26 at 00:18 -0700, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
>  
> > > Ehem, is ALSA broken ?
> > > 
> > > I can't spread stereo output to 4 channel. More specific, I can't switch
> > > one of my female jacks between in and out.
> > >

You are using alsamixer and not some GUI mixer, right?  There were
recently some changes to the ALSA mixer API and AFAIK none of the GUI
mixers have caught up yet.

> > Side note: trying to load settings from rc4 in -mm says:
> > 
> > alsactl: set_control:930: warning: name mismatch (Surround Jack as Input/Surround Jack Mode) for control #42
> > alsactl: set_control:932: warning: index mismatch (0/0) for control #42
> > alsactl: set_control:1030: bad control.42.value type
> > 

These are harmless, it's just telling you that because control #42 was
renamed from "Surround Jack as Input" to "Surround Jack Mode".  Looks
like it was changed from a boolean to an enumerated control.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
