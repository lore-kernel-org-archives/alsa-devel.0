From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: ALSA vs OSS/free
Date: Thu, 07 Mar 2002 16:32:43 +0100
Message-ID: <a681ks$ghh$1@quimby2.netfonds.no>
References: <Pine.LNX.4.44.0203071529210.923-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0203071529210.923-100000@ecabase.localdomain> (Kai Vehmanen's message of "Thu, 7 Mar 2002 15:55:31 +0200 (EET)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <k@eca.cx>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

Kai Vehmanen <k@eca.cx> writes:
> [alsa-kernel/alsa-driver]
> - better driver architecture
> 	- more shared code between drivers for 
> 	  different soundcards 

       no need to reinvent the wheel in every driver

       distro maintainers build monuments in honor of alsa team
       because of space saving.
       eg: current cooker up kernel (2.4.18-4mdk) has 15Mb of gzipped
       modules: 1.1mb for 54 snd-card-* modules (total: 115 modules)
       vs 683kb for 40 cards modules (total: 49 modules)

       still to do: merge snd-card-es137{0,1} binaries

> - support for pro-level soundcards without performance problems
> 	- for instance handling devices that only support 
> 	  noninterleaved buffer layout
> 	- befefits ALSA-native apps (and in some cases also
> 	  apps using OSS-emulation)

     - support for quite a number of cards not supported by oss/free


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
