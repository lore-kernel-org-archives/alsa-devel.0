From: Patricio Paez <pp@pp.com.mx>
Subject: [PATCH] Fix typos in ALSA Lib documentation
Date: Sun, 22 Feb 2009 07:54:10 -0600
Message-ID: <20090222135409.GA4475@ubu.pp.com.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.webfaction.com (mail1.webfaction.com [67.15.2.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 60C7E24509
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 14:54:18 +0100 (CET)
Received: from pp.com.mx (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by mail1.webfaction.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1MDsAlm027437
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 07:54:11 -0600
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Patricio Paez <pp@pp.com.mx>

diff --git a/src/seq/seq.c b/src/seq/seq.c
index feb9733..7b777a1 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -30,7 +30,7 @@
 
 /*! \page seq Sequencer interface
 
-\section seq_general Genral
+\section seq_general General
 
 The ALSA sequencer interface is designed to deliver the MIDI-like
 events between clients/ports.
@@ -76,10 +76,10 @@ A client can have one or more <i>ports</i> to communicate between other
 clients.  A port is corresponding to the MIDI port in the case of MIDI device,
 but in general it is nothing but the access point between other clients.
 Each port may have capability flags, which specify the read/write
-accessbility and subscription permissions of the port.
+accessibility and subscription permissions of the port.
 For creation of a port, call #snd_seq_create_port()
-with the appropirate port attribute specified in #snd_seq_port_info_t
-reocrd.
+with the appropriate port attribute specified in #snd_seq_port_info_t
+record.
 
 For creating a port for the normal use, there is a helper function
 #snd_seq_create_simple_port().  An example with this function is like below.
@@ -102,7 +102,7 @@ Here, input and output mean
 input (read) from other clients and output (write) to others, respectively.
 Since memory pool of each client is independent from others,
 it avoids such a situation that a client eats the whole events pool
-and interfere other clients' responce.
+and interfere other clients' response.
 
 The all scheduled output events or input events from dispatcher are stored
 on these pools until delivered to other clients or extracted to user space.
@@ -171,7 +171,7 @@ the MIDI events like program, velocity or chorus effects.
 This application can accept arbitrary MIDI input
 and send to arbitrary port, just like a Unix pipe application using
 stdin and stdout files.
-We can even connect several filter applictions which work individually
+We can even connect several filter applications which work individually
 in order to process the MIDI events.
 Subscription can be used for this purpose.
 The connection between ports can be done also by the "third" client.
@@ -199,7 +199,7 @@ All the sequencer events are stored in a sequencer event record,
 #snd_seq_event_t type.
 Application can send and receive these event records to/from other
 clients via sequencer.
-An event has several stroage types according to its usage.
+An event has several storage types according to its usage.
 For example, a SYSEX message is stored on the variable length event,
 and a large synth sample data is delivered using a user-space data pointer.
 
@@ -227,7 +227,7 @@ The type field contains the type of the event
 (1 byte).
 The flags field consists of bit flags which
 describe several conditions of the event (1 byte).
-It includes the time-stamp mode, data storage type, and scheduling prority.
+It includes the time-stamp mode, data storage type, and scheduling priority.
 The tag field is an arbitrary tag.
 This tag can used for removing a distinct event from the event queue
 via #snd_seq_remove_events().
@@ -240,7 +240,7 @@ The data field is a union of event data.
 An event can be delivered either on scheduled or direct dispatch mode.
 On the scheduling mode, an event is once stored on the priority queue
 and delivered later (or even immediately) to the destination,
-whereas on the direct disatch mode, an event is passed to the destination
+whereas on the direct dispatch mode, an event is passed to the destination
 without any queue.
 
 For a scheduled delivery, a queue to process the event must exist.
@@ -284,7 +284,7 @@ The time stored in an event record is a union of these two different
 time values.
 
 Note that the time format used for real time events is very similar to
-timeval struct used for unix system time.
+timeval struct used for Unix system time.
 The absurd resolution of the timestamps allows us to perform very accurate
 conversions between songposition and real time. Round-off errors can be
 neglected.
@@ -299,7 +299,7 @@ counted from the moment when the queue started.
 An client that relies on these relative timestamps is the MIDI input port.
 As each sequencer queue has it's own clock the only way to deliver events at
 the right time is by using the relative timestamp format. When the event
-arrives at the queue it is normalised to absolute format.
+arrives at the queue it is normalized to absolute format.
 
 The timestamp format is specified in the flag bitfield masked by
 #SND_SEQ_TIME_STAMP_MASK.
@@ -320,7 +320,7 @@ fill the port id of source.port and
 both client and port of dest field.
 
 If an existing address is set to the destination,
-the event is simplly delivered to it.
+the event is simply delivered to it.
 When #SND_SEQ_ADDRESS_SUBSCRIBERS is set to the destination client id,
 the event is delivered to all the clients connected to the source port.
 
@@ -346,7 +346,7 @@ an announcement is sent to subscribers from this port.
 
 Some events like SYSEX message, however, need larger data space
 than the standard data.
-For such events, ALSA sequencer provides seveal different data storage types.
+For such events, ALSA sequencer provides several different data storage types.
 The data type is specified in the flag bits masked by #SND_SEQ_EVENT_LENGTH_MASK.
 The following data types are available:
 
@@ -359,7 +359,7 @@ A macro #snd_seq_ev_set_fixed() is provided to set this type.
 \par Variable length data
 SYSEX or a returned error use this type.
 The actual data is stored on an extra allocated space.
-On sequecer kernel, the whole extra-data is duplicated, so that the event
+On sequencer kernel, the whole extra-data is duplicated, so that the event
 can be scheduled on queue.
 The data contains only the length and the
 pointer of extra-data.
@@ -430,7 +430,7 @@ Note that PPQ cannot be changed while the queue is running.
 It must be set before the queue is started.
 
 On the other hand, in the case of <i>realtime</i> queue, the
-time resolution is fixed to nanosecononds.  There is, however,
+time resolution is fixed to nanoseconds.  There is, however,
 a parameter to change the speed of this queue, called <i>skew</i>.
 You can make the queue faster or slower by setting the skew value
 bigger or smaller.  In the API, the skew is defined by two values,
@@ -488,7 +488,7 @@ special settings.
 In the above example, the tempo is changed immediately after
 the buffer is flushed by #snd_seq_drain_output() call.
 You can schedule the event in a certain queue so that the tempo
-change happes at the scheduled time, too.
+change happens at the scheduled time, too.
 
 \subsection seq_ev_start Starting and stopping a queue
 
@@ -515,7 +515,7 @@ Each ALSA port can have capability flags.
 The most basic capability flags are
 #SND_SEQ_PORT_CAP_READ and #SND_SEQ_PORT_CAP_WRITE.
 The former means that the port allows to send events to other ports,
-whereas the latter capability menas
+whereas the latter capability means
 that the port allows to receive events from other ports.
 You may have noticed that meanings of \c READ and \c WRITE
 are permissions of the port from the viewpoint of other ports.
@@ -536,7 +536,7 @@ Obviously, these flags have no influence
 if \c READ or \c WRITE> capability is not set.
 
 Note that these flags are not necessary if the client subscribes itself
-to the spcified port.
+to the specified port.
 For example, when a port makes READ subscription
 to MIDI input port, this port must have #SND_SEQ_PORT_CAP_WRITE capability,
 but no #SND_SEQ_PORT_CAP_SUBS_WRITE capability is required.
@@ -610,7 +610,7 @@ if #SND_SEQ_PORT_CAP_NO_EXPORT capability is set in either sender or receiver po
 
 Assume MIDI input port = 64:0, application port = 128:0, and
 queue for timestamp = 1 with real-time stamp.
-The application port must have capabilty #SND_SEQ_PORT_CAP_WRITE.
+The application port must have capability #SND_SEQ_PORT_CAP_WRITE.
 \code
 void capture_keyboard(snd_seq_t *seq)
 {
@@ -633,7 +633,7 @@ void capture_keyboard(snd_seq_t *seq)
 \subsection seq_subs_ex_out Output to MIDI device
 
 Assume MIDI output port = 65:1 and application port = 128:0.
-The application port must have capabilty #SND_SEQ_PORT_CAP_READ.
+The application port must have capability #SND_SEQ_PORT_CAP_READ.
 \code
 void subscribe_output(snd_seq_t *seq)
 {
@@ -790,7 +790,7 @@ void event_filter(snd_seq_t *seq, snd_seq_event_t *ev)
 /**
  * \brief get identifier of sequencer handle
  * \param seq sequencer handle
- * \return ascii identifier of sequencer handle
+ * \return ASCII identifier of sequencer handle
  *
  * Returns the ASCII identifier of the given sequencer handle. It's the same
  * identifier specified in snd_seq_open().
@@ -1610,7 +1610,7 @@ void snd_seq_client_info_event_filter_del(snd_seq_client_info_t *info, int event
  * \param event_type event type to be checked
  * \return 1 if the event type is present, 0 otherwise
  *
- * Test if the event type is in the filter bitamp of this client_info container.
+ * Test if the event type is in the filter bitmap of this client_info container.
  *
  * \sa snd_seq_get_client_info(),
  *     snd_seq_set_client_info(),
diff --git a/src/seq/seqmid.c b/src/seq/seqmid.c
index 3b0960d..86a4970 100644
--- a/src/seq/seqmid.c
+++ b/src/seq/seqmid.c
@@ -317,7 +317,7 @@ int snd_seq_set_client_pool_input(snd_seq_t *seq, size_t size)
  * \param seq sequencer handle
  * \return 0 on success or negative error code
  *
- * So far, this works ideically like #snd_seq_drop_output().
+ * So far, this works identically like #snd_seq_drop_output().
  */
 int snd_seq_reset_pool_output(snd_seq_t *seq)
 {
@@ -329,7 +329,7 @@ int snd_seq_reset_pool_output(snd_seq_t *seq)
  * \param seq sequencer handle
  * \return 0 on success or negative error code
  *
- * So far, this works ideically like #snd_seq_drop_input().
+ * So far, this works identically like #snd_seq_drop_input().
  */
 int snd_seq_reset_pool_input(snd_seq_t *seq)
 {
-- 
1.5.6.3
