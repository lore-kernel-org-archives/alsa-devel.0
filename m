From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Sat, 16 Oct 2010 09:52:54 +0800
Message-ID: <1287193974.2133.2.camel@desktop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<1287153698.3730.7.camel@laptop-alex>
	<201010151916.26003.julian@jusst.de>
	<201010151919.41810.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp44.singnet.com.sg (smtp44.singnet.com.sg [165.21.103.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 840712457F
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 03:52:59 +0200 (CEST)
In-Reply-To: <201010151919.41810.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-15 at 19:19 +0200, Julian Scheel wrote:

> 
> Correcting myself. It detects the card, but playback is not possible anymore:
> 
> LC_ALL=en speaker-test -Dusb -c 2 -t sine -f 1000
> 
> speaker-test 1.0.23
> 
> Playback device is usb
> Stream parameters are 48000Hz, S16_LE, 2 channels
> Sine wave rate is 1000.0000Hz
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 96 to 262144
> Period size range from 48 to 131072
> Using max buffer size 262144
> Periods = 4
> Unable to set hw params for playback: Broken pipe
> Setting of hwparams failed: Broken pipe
> 
> Is this a hint to not-working feedback? (c:

You may need to respond to the specific requests for get and set of the
sampling rate of the audio stream, once you have the Sample Rate
Attribute set.  See my sdr-widget code to process these requests:

   //  assume all other requests are for AUDIO interface

	   switch (request)
	    {
	       case BR_REQUEST_SET_CUR:
	          audio_set_cur();
	          return TRUE;
	          // No need to break here !

	       case BR_REQUEST_SET_MIN:     //! Set MIN,MAX and RES not
supported
	       case BR_REQUEST_SET_MAX:
	       case BR_REQUEST_SET_RES:
	          return FALSE;
	          // No need to break here !

	       case BR_REQUEST_GET_CUR:
	          audio_get_cur();
	          return TRUE;
	          // No need to break here !

	       case BR_REQUEST_GET_MIN:
	          audio_get_min();
	          return TRUE;
	          // No need to break here !

	       case BR_REQUEST_GET_MAX:
	          audio_get_max();
	          return TRUE;
	          // No need to break here !

	       case BR_REQUEST_GET_RES:
	          audio_get_res();
	          return TRUE;
	          // No need to break here !

	       default:
	          return FALSE;
	          // No need to break here !
	    }
