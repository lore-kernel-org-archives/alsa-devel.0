From: Johan Bilien <jobi@via.ecp.fr>
Subject: Re: start_threshold having no effect
Date: Tue, 21 Oct 2003 14:28:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031021122857.GA30898@via.ecp.fr>
References: <20031020173030.GC28408@via.ecp.fr> <200310202223.h9KMNQlC022039@oud.linuxaudiosystems.com> <20031021095054.GB30326@via.ecp.fr> <Pine.LNX.4.53.0310211326180.25721@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0310211326180.25721@pnote.perex-int.cz>
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

On Tue, Oct 21, 2003, Jaroslav Kysela wrote:
> For a voice IP applications, it probably make sense to work without over
> and underrun detection (yes, if CPU is busy, there will be some scratches,
> but you'll avoid resyncing). Simply set stop_threshold to boundary for
> the no-xrun detection.

Thanks a lot, I did this and was then able to run the application with
delays of about 10 ms.

-- 
Jobi


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
